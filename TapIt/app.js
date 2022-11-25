require("dotenv").config();

const express = require("express");
const errorHandler = require("errorhandler");
const bodyParser = require("body-parser");
const methodOverride = require("method-override");
const logger = require("morgan");


const app = express();
const port = process.env.PORT || 3000;

app.use(logger("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(methodOverride("_method"));
app.use(errorHandler());

let user = require('./routers/user');
let emergency = require('./routers/emergency');

app.get("/", (req, res) => {
  res.status(200).json("hey");
});

app.use('/user',user);
app.use('/emergency',emergency)

app.listen(port,() => {
  console.log(`App listening on port ${port}`);
});
