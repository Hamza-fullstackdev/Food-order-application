import mongoose from "mongoose";

const mongoDbConnection = process.env.MONGODB_URI;

if (!mongoDbConnection) {
  throw new Error("Please define the MONGODB_URI environment variable");
}

let cached = global.mongoose;

if (!cached) {
  cached = global.mongoose = { conn: null, promise: null };
}

export const connectToDatabase = async () => {
  if (cached.conn) return cached.conn;

  if (!cached.promise) {
    cached.promise = mongoose
      .connect(mongoDbConnection, {
        dbName: process.env.DATABASE,
        bufferCommands: false,
        maxPoolSize: 10,
      })
      .then((mongoose) => mongoose);
  }

  cached.conn = await cached.promise;
  return cached.conn;
};
