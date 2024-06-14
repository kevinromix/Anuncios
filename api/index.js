import express, { json } from "express";
import fs from "fs";
import bodyParser from "body-parser";
import nodemailer from "nodemailer";
import { config } from "./config.js";

const app = express();
app.use(bodyParser.json());

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
  res.send("Welcome to my API with Node js");
});

// Obtener Autos
app.get("/api/autos", async (req, res) => {
  const pageSize = 5; // Number of items per page
  const pageNumber = req.query.page || 1; // Get the current page number from the query parameters
  const startIndex = (pageNumber - 1) * pageSize;
  const endIndex = startIndex + pageSize;
  const data = await readData("cars");
  const autos = data.slice(startIndex, endIndex);
  res.status(200).json(autos);
});

app.post("/api/mensaje", async (req, res) => {
  const body = req.body;
  let transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
      user: config.mail,
      pass: config.pass,
    },
  });

  let nombre = body.Nombre;
  let correo = body.Correo;
  let mensaje = body.Mensaje;

  transporter.verify().then(() => {
    console.log("Ready for send emails");
  });

  try {
    await transporter.sendMail({
      from: '"Anuncios" <' + config.mail + ">",
      to: config.mail,
      subject: "Nuevo Mensaje",
      html: `
      <b>SE RECIBIO UN COMENTARIO DESDE EL SISTEMA DE ANUNCIOS EMPRESARIALES CON LA SIGUIENTE INFORMACÓN DE CONTACTO</b>
      <br />
      <br />
       <div><b>NOMBRE:</b> ${nombre}</div>
       <div><b>CORREO CONTACTO:</b> ${correo}</div>
       <b>MENSAJE:</b>
       <div>${mensaje}</div>
      `,
    });
  } catch (er) {
    console.log(er);
    res.status(500).json({});
  }
  res.status(200).json({});
});

app.listen(3000, () => {
  console.log("Server listening on port 3000");
});
