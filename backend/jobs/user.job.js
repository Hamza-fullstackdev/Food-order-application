import cron from "node-cron";
import path from "path";
import fs from "fs";
import { fileURLToPath } from "url";
import yaml from "js-yaml";
import mongoose from "mongoose";
import ExcelJS from "exceljs";
import User from "../models/User.model.js";
import { connectToDatabase } from "../config/db.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function getPakistanTimestamp() {
  const now = new Date();
  const formatter = new Intl.DateTimeFormat("en-GB", {
    timeZone: "Asia/Karachi",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
    second: "2-digit",
    hour12: false,
  });
  const parts = formatter.formatToParts(now);
  const lookup = Object.fromEntries(parts.map((p) => [p.type, p.value]));
  return `${lookup.year}-${lookup.month}-${lookup.day}_${lookup.hour}-${lookup.minute}-${lookup.second}`;
}

function flattenUser(p) {
  return {
    _id: p._id?.toString() || "",
    name: p.name ?? "",
    email: p.email ?? "",
    password: p.password ?? "",
    phoneNumber: p.phoneNumber ?? "",
    profileImage: p.profileImage ?? "",
    imageId: p.imageId ?? "",
    isAdmin: p.isAdmin ?? false,
    isBlocked: p.isBlocked ?? false,
    refreshToken: p.refreshToken ?? "",
    createdAt: p.createdAt ? new Date(p.createdAt).toISOString() : "",
    updatedAt: p.updatedAt ? new Date(p.updatedAt).toISOString() : "",
  };
}

async function ensureConnected() {
  if (mongoose.connection.readyState !== 1) {
    await connectToDatabase();
  }
}

export const startUserBackup = () => {
  cron.schedule("0 0 * * 0", async () => {
    try {
      await ensureConnected();
      console.log("Running backup...");
      const users = await User.find().lean();

      if (!users || users.length === 0) {
        console.log("No Users found to backup.");
        return;
      }

      const timestamp = getPakistanTimestamp();
      const folderName = `backup-users-${timestamp}`;
      const backupDir = path.join(
        __dirname,
        "..",
        "backups",
        "users",
        folderName
      );
      fs.mkdirSync(backupDir, { recursive: true });

      const formatedUsers = users.map(flattenUser);

      const workbook = new ExcelJS.Workbook();
      const sheet = workbook.addWorksheet("Users");
      sheet.columns = Object.keys(formatedUsers[0]).map((key) => ({
        header: key,
        key: key,
      }));
      formatedUsers.forEach((item) => sheet.addRow(item));
      const excelFile = path.join(backupDir, `users-${timestamp}.xlsx`);
      await workbook.xlsx.writeFile(excelFile);

      const jsonFile = path.join(backupDir, `users-${timestamp}.json`);
      fs.writeFileSync(jsonFile, JSON.stringify(users, null, 2));

      const csvFile = path.join(backupDir, `users-${timestamp}.csv`);
      await workbook.csv.writeFile(csvFile);

      const yamlFile = path.join(backupDir, `users-${timestamp}.yml`);
      fs.writeFileSync(yamlFile, yaml.dump(users));

      console.log(`Backup saved:
                  Excel   : ${excelFile}
                  JSON    : ${jsonFile}
                  CSV     : ${csvFile}
                  YAML    : ${yamlFile}
                  `);
    } catch (err) {
      console.error("Backup failed:", err);
    }
  });
};
