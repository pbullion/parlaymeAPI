const express = require('express');
const bodyParser = require('body-parser');
const routes = require('./routes');
var cors = require('cors');

const app = express();

app.use(cors());

app.use(bodyParser.json());

app.use('/', routes);

app.use((err, req, res, next) => {
    res.json(err);
});

module.exports = app;
