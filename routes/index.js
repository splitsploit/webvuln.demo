var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index');
});

router.get('/spam-detect', function(req, res, next) {
  res.render('spamDetector');
});

module.exports = router;
