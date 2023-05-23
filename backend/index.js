require('dotenv').config();
const express = require('express');
const app = express();
const { validationResult, check } = require('express-validator');
const prompt_ia = require('./prompt_ia');

app.get('/',async (req, res, next) => {
    return res.status(200).send('Api working');
});

app.get('/line_orthograph', async (req, res, next) => {
    if (req.query.to_process == null)
        return res.status(500).send('error');
    answer = await prompt_ia("corrige les fautes de frappe/ortographe de cette phrase si besoin:", req.query.to_process).catch(err => {
        return res.status(500).send('Error');
    });
    return res.status(200).send(answer);
});

app.get('/listify', async (req, res, next) => {
    if (req.query.to_process == null)
        return res.status(500).send('error');
    answer = await prompt_ia("met en forme cette liste, avec * au debut de chaque ligne", req.query.to_process).catch(err => {
        return res.status(500).send('Error');
    });
    return res.status(200).send(answer);
});

app.get('/improve_line', async (req, res, next) => {
    if (req.query.to_process == null)
        return res.status(500).send('error');
    answer = await prompt_ia("Améliore la formulation de cette phrase", req.query.to_process).catch(err => {
        return res.status(500).send('Error');
    });
    return res.status(200).send(answer);
});

app.get('/sort_list', async (req, res, next) => {
    if (req.query.to_process == null)
        return res.status(500).send('error');
    answer = await prompt_ia("Réécris cette liste de manière triée", req.query.to_process).catch(err => {
        return res.status(500).send('Error');
    });
    return res.status(200).send(answer);
});

app.listen(3000, () => {
  console.log(`Server is listening on port ${process.env.PORT || 3000}`);
});
