const express = require('express');
const monk = require('monk');
const Joi = require('@hapi/joi');

const db = monk(process.env.MONGO_URI);
const router = express.Router();

const messages = db.get('messages');
const schema = Joi.object({
  head: Joi.string().trim().required(),
  body: Joi.string().trim().required(),
  picture_url: Joi.string().uri(),
});

// READ ALL
router.get('/', async (req, res, next) => {
  try {
    const items = await messages.find({});
    res.json(items);
  } catch (error) {
    next(error);
  }
});

// READ ONE
router.get('/:id', async (req, res, next) => {
  try {
    const { id } = req.params;
    const item = await messages.findOne({
      _id: id,
    });
    if (!item) return next();

    res.json(item);
  } catch (error) {
    next(error);
  }
  return null;
});

// CREATE ONE
router.post('/', async (req, res, next) => {
  try {
    const value = await schema.validateAsync(req.body);
    const inserted = await messages.insert(value);
    res.json(inserted);
  } catch (error) {
    next(error);
  }
});

// UPDATE ONE
router.put('/:id', async (req, res, next) => {
  try {
    const { id } = req.params;
    const value = await schema.validateAsync(req.body);
    const item = await messages.findOne({
      _id: id,
    });
    if (!item) return next();
    const updated = await messages.update({
      _id: id
    }, {
      $set: value,
    });
    res.json(updated);
  } catch (error) {
    next(error);
  }
  return null;
});

// DELETE ONE
router.delete('/:id', async (req, res, next) => {
  try {
    const { id } = req.params;
    await messages.remove({ _id: id });
    res.status(200).send(`DEL ${id} Success`);
  } catch (error) {
    next(error);
  }
});

module.exports = router;
