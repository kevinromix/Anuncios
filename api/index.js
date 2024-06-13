import express from "express";

const app = express();

app.get("/", (req, res) => {
  res.send("Welcome to my first API with Node js");
});

app.get("/autos", (req, res) => {
    res.send("Welcome to my first API with Node js");
  });
  

app.listen(3000, () => {
  console.log("Server listening on port 3000");
});
