const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser')

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());

// Mongodb setup.
mongoose.connect(process.env.DB_URL || "mongodb://0.0.0.0:27017");

const MessageModel = mongoose.model('Message', { 
  content: String
});

// Routes
app.get('/', (req, res) => {
  res.send("==========\nHello, world!!\n==========");
});

app.get('/message', async (req, res) => {
  try {
    const strings = await MessageModel.find();
    res.json(strings);
  } catch {
    res.send("Deu errado!");
  }
});

app.post('/data', async (req, res) => {
  try {
    const { content } = req.body
    const newMessage = new MessageModel({ content });

    await newMessage.save();
    res.send("String salva no BD!");
  } catch (e) {
    res.send(e.message);
  }
})

app.listen(PORT, () => {
  console.log("Api is listening on ${PORT}");
});

