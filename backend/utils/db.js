import mongoose from "mongoose";

const mongoDbConnection = process.env.MONGODB_URI;

if (!mongoDbConnection) {
  throw new Error(
    "Please define the MONGODB_URI environment variable inside envoirement file"
  );
}

let isConnected = false;

export const connectToDatabase = async () => {
  if (isConnected) {
    return;  

  }

  try {
    await mongoose.connect(mongoDbConnection, {
      dbName: process.env.DATABASE,
      bufferCommands: false,
    });

    isConnected = true;
    console.log("MongoDB connected");
  } catch (error) {
    console.error("MongoDB connection error:", error);
    throw error;
  }
};
