const { Router } = require('express');
const homeScreen = require('./homeScreen');

const router = Router();

router.use('/', homeScreen);

module.exports = router;
