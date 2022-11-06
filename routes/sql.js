var express = require('express');
var router = express.Router();

router.get('/', function(req, res, next) {
  res.render('sql/index');
});

router.get("/playground", function(req, res){
  res.render('sql/playground');
});

router.get("/tutorial", function(req, res){
  res.render('sql/tutorial');
});

module.exports = router;
