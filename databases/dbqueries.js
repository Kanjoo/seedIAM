const { request } = require('express');
const express = require('express');
const app = express();
const res = require('express/lib/response');
const req = require('express/lib/request');
const db = require('./db');


// const createQuery = 'INSERT INTO users(name, email, mobile_no, password) VALUES($1, $2, $3, $4)';

// Query psql if users already exist before registering a new account!
const findOne = () => {
  let email = req.body.email;
  db.query('SELECT * FROM users WHERE email = $1', [email], (err, results) => {
    if(err) {
      throw err;
    }
    console.log(results);
  });
}; 


// const readAllQuery = 'SELECT * FROM users';

// const readOneQuery = 'SELECT * FROM users WHERE email = $2 AND password = $4';

// const updateQuery = 'UPDATE users SET name = $2, email = $3, mobile_no = $4, password = $5 WHERE id = $1';

// const deleteQuery = 'DELETE FROM users WHERE id = $1';
db.query(readAllQuery, (err,res) => {
  if (!err) {
    console.log(res.rows);
  } else {
    console.log(err);
  }
});



const userProfile = () => {
};

const createUser = () => {  
  pool.query(createQuery, (err, res) => {
    if (!err) {
      console.log(res.rows);
    } else {
      console.log(err);
    }
  });
};

const loginUser = () => { 
  const {
    email,
    password
  } = req.body;
  db.query(readOneQuery, [email, password], (err, res) => {
    if (!err) {
      console.log(res.rows);
    } else {
      console.log(err);
    }
  });
};

const getUserById = () => {
  db.query(readOneQuery, (err, res) => {
    if (!err) {
      console.log(res.rows);
    } else {
      console.log(err);
    }
  });
};

const getUsers = () => {
  db.query(readAllQuery, (err, res) => {
    if (!err) {
      console.log(res.rows);
    } else {
      console.log(err);
    }
  });
};

const updateUser = () => {
  db.query(updateQuery, (err, res) => {
    if (!err) {
      console.log(res.rows);
    } else {
      console.log(err);
    }
  });
};

const deleteUser = () => {
  db.query(deleteQuery, (err, res) => {
    if (!err) {
      console.log(`Your account has been successfully deleted!`);
    } else {
      console.log(err);
    }
  });
};

module.exports = {
  // userProfile,
  // createUser,
  findOne,
  // loginUser,
  // getUserById,
  // getUsers,
  // updateUser,
  // deleteUser
};

/** name: 'Khoero Eixas',
    email: 'ke@eixas.com',
    mobile_no: '+243 654 928 7310',
    created_on: null,
    last_login: null,
    password: 'mitur38x@$' */
