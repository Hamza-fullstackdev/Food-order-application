import cron from "node-cron";
import Product from "../models/Product.model.js";
import path from "path";
import fs from "fs";
import { fileURLToPath } from "url";
import yaml from "js-yaml";
import mongoose from "mongoose";
import ExcelJS from "exceljs";
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

function flattenProduct(p) {
  return {
    _id: p._id?.toString() || "",
    userId: p.userId?._id?.toString?.() || String(p.userId) || "",
    categoryId: p.categoryId?._id?.toString?.() || String(p.categoryId) || "",
    subcategoryId:
      p.subcategoryId?._id?.toString?.() || String(p.subcategoryId) || "",
    name: p.name ?? "",
    shortDescription: p.shortDescription ?? "",
    description: p.description ?? "",
    price: p.price ?? null,
    image: p.image ?? "",
    imageId: p.imageId ?? "",
    variantGroups: JSON.stringify(p.variantGroups || []),
    createdAt: p.createdAt ? new Date(p.createdAt).toISOString() : "",
    updatedAt: p.updatedAt ? new Date(p.updatedAt).toISOString() : "",
  };
}

async function ensureConnected() {
  if (mongoose.connection.readyState !== 1) {
    await connectToDatabase();
  }
}

export const startProductBackup = () => {
  cron.schedule("0 0 * * 0", async () => {
    try {
      await ensureConnected();

      console.log("Running backup...");

      const products = await Product.find()
        .populate("userId")
        .populate("categoryId")
        .populate("subcategoryId")
        .lean();

      if (!products || products.length === 0) {
        console.log("No products found to backup.");
        return;
      }

      const timestamp = getPakistanTimestamp();
      const folderName = `backup-products-${timestamp}`;
      const backupDir = path.join(
        __dirname,
        "..",
        "backups",
        "products",
        folderName
      );
      fs.mkdirSync(backupDir, { recursive: true });

      const formattedProducts = products.map(flattenProduct);

      const workbook = new ExcelJS.Workbook();
      const sheet = workbook.addWorksheet("Products");
      sheet.columns = Object.keys(formattedProducts[0]).map((key) => ({
        header: key,
        key: key,
      }));
      formattedProducts.forEach((item) => sheet.addRow(item));
      const excelFile = path.join(backupDir, `products-${timestamp}.xlsx`);
      await workbook.xlsx.writeFile(excelFile);

      const jsonFile = path.join(backupDir, `products-${timestamp}.json`);
      fs.writeFileSync(jsonFile, JSON.stringify(products, null, 2));

      const csvFile = path.join(backupDir, `products-${timestamp}.csv`);
      await workbook.csv.writeFile(csvFile);

      const yamlFile = path.join(backupDir, `products-${timestamp}.yml`);
      fs.writeFileSync(yamlFile, yaml.dump(products));

      console.log(`✅ Backup saved:
                  Excel   : ${excelFile}
                  JSON    : ${jsonFile}
                  CSV     : ${csvFile}
                  YAML    : ${yamlFile}
                  `);
    } catch (err) {
      console.error("❌ Backup failed:", err);
    }
  });
};
