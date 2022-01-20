const express = require('express');
const res = require('express/lib/response');
const router = express.Router();

//This middleware is specific to this router
router.use(function timeLog(req, res, next) {
  console.log('Time:', Date.now());
  next();
});

router.get('/', (req, res) => {
  res.send('Get the sign in page');
});

router.post('/process_login', (req, res, next) => {
  //   req.body comes from urlencoded which parses the http messages for sent data
  const password = req.body.password;
  const username = req.body.username;
  if (password === 'pa33') {
    res.cookie('username', username);
    res.redirect('/welcome');
  } else {
    res.redirect('/login?msg=fail');
  }

  //res.json(req.body);
  next();
});

router.get('/welcome', (req, res, next) => {
  res.render('welcome', {
    username: req.cookies.username
  });
  next();
});

router.post('/process_register', (req, res) => {
  res.send("Can we get an AMEN?!");
});



module.exports = router;
