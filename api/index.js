import express from "express";
import fs from "fs";

const app = express();

const readData = () => {
  try {
    const data = fs.readFileSync("./db.json");
    return JSON.parse(data);
  } catch (e) {
    console.log(e);
  }
};

app.get("/", (req, res) => {
  res.send("Welcome to my first API with Node js");
});

app.get("/autos", (req, res) => {
  const data = readData();
  res.json(data.cars);
});

app.listen(3000, () => {
  console.log("Server listening on port 3000");
});
