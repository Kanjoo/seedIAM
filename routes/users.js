const express = require('express');
const res = require('express/lib/response');
const router = express.Router();
const db = require('../databases/db');


//This middleware is specific to this router
router.use(function timeLog(req, res, next) {
  console.log('Time:', Date.now());
  next();
});

// Register new users
router.post('/process_register', (req, res) => {
  // Step 1. Test that form input are working.
  // console.log(req.body);

  let {
    name,email, mobile_no, password
  } = req.body;

  let hash = bcrypt.hashSync(password, 13);
  const 

  db.query('SELECT * FROM users WHERE email = $1', [email], (err, results) => {
    if (err) {
      throw err;
    }
    console.log(results);
  });
});

/*router.post('/process_register', (req, res, next) => {
  const username = req.body.username;
  const password = req.body.password;
  const email = req.body.email;
  if (password === 'pa33') {
    res.cookie('email', email);
    res.redirect('/welcome');
  } else {
    res.redirect('/signup?msg=username and password already in use.');
  }
  //res.json(req.body);
  //res.send("Can we get an AMEN?!");
  next();
});*/

router.get('/', (req, res, next) => {
  res.clearCookie('email');
  res.redirect('/');
  next();
});

module.exports = router;
