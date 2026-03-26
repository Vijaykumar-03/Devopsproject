const express = require("express");
const path = require("path");
const os = require("os");

const app = express();

// Environment variables
const PORT = process.env.PORT || 3000;
const APP_NAME = process.env.APP_NAME || "Vijay DevOps Portfolio";

// Middleware
app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

// Logger (important for DevOps)
app.use((req, res, next) => {
  console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
  next();
});

// Routes
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

// Health check (used by monitoring tools)
app.get("/health", (req, res) => {
  res.status(200).json({
    status: "UP",
    app: APP_NAME,
    uptime: process.uptime()
  });
});

// System info (for debugging/demo)
app.get("/info", (req, res) => {
  res.json({
    app: APP_NAME,
    hostname: os.hostname(),
    platform: os.platform(),
    cpuCores: os.cpus().length,
    memory: `${Math.round(os.totalmem() / 1024 / 1024)} MB`
  });
});

// Error handling
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "Internal Server Error" });
});

// Start server
app.listen(PORT, () => {
  console.log(`${APP_NAME} running on port ${PORT}`);
});
