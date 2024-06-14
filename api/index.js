import express from "express";
import fs from "fs";

const app = express();

function sleep(ms) {
  return new Promise((resolve) => {
    setTimeout(resolve, ms);
  });
}

const readData = async (type) => {
  try {
    const data = fs.readFileSync(`./${type}.json`);
    await sleep(1000);
    return JSON.parse(data);
  } catch (e) {
    console.log(e);
  }
};

app.get("/", (req, res) => {
  res.send("Welcome to my first API with Node js");
});

// Obtener Autos
app.get("/api/autos", async (req, res) => {
  const pageSize = 5; // Number of items per page
  const pageNumber = req.query.page || 1; // Get the current page number from the query parameters
  const startIndex = (pageNumber - 1) * pageSize;
  const endIndex = startIndex + pageSize;
  const data = await readData("cars");
  const autos = data.slice(startIndex, endIndex);
  res.json(autos);
});

app.listen(3000, () => {
  console.log("Server listening on port 3000");
});
