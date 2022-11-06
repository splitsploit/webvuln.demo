const db = require("../config/dbConnect");
const {
  v4: uuidv4
} = require("uuid");

const verifyUser = async (username, passwd) => {
  return new Promise((resolve, reject) => {
    console.log(`select username from users where username = '${username}' and password = '${passwd}'`);

    db.query(`select username from users where username = '${username}' and password = '${passwd}'`, 
    (err, result) => {

      if(err){
        console.error(err);
        reject("Server Error");
        return;
      }
      
      if(!result || result.length == 0){
        reject("Invalid Credentials");
        return;
      }

      resolve(result);
    });
  });
}

const verifyUserSecure = async (username, passwd) => {
  return new Promise((resolve, reject) => {

    db.query(`select username from users where username = ? and password = ?`, [username, passwd], 
    (err, result) => {

      if(err){
        console.error(err);
        reject("Server Error");
        return;
      }
      
      if(!result || result.length == 0){
        reject("Invalid Credentials");
        return;
      }

      resolve(result);
    });
  });
}

const loginWithCredentials = async (acc_no, passwd) => {
  return new Promise((resolve, reject) => {

    db.query(`select acc_no from accounts where acc_no = ? and password = ?`, [acc_no, passwd], 
    (err, result) => {

      if(err){
        console.error(err);
        reject("Server Error");
        return;
      }
      
      if(!result || result.length == 0){
        reject("Invalid Credentials");
        return;
      }

      resolve(result);
    });
  });
}

const getUserDetails = async (acc_no) => {
  return new Promise((resolve, reject) => {

    db.query(`select acc_no, balance from accounts where acc_no = ?`, [acc_no], 
    (err, result) => {

      if(err){
        console.error(err);
        reject("Server Error");
        return;
      }
      
      if(!result || result.length == 0){
        reject("User Not Found");
        return;
      }

      resolve(result[0]);
    });
  });
}

const updateBalancesAndRecord = async (from_acc_no, to_acc_no, amount) => {
  return new Promise((resolve, reject) => {

    db.beginTransaction();

    db.query(`update accounts set balance = balance - ? where acc_no = ?`, [amount, from_acc_no], 
    (err, result) => {

      if(err){
        console.error(err);
        reject("Internal Server Error");
        return;
      }
      
      db.query(`update accounts set balance = balance + ? where acc_no = ?`, [amount, to_acc_no],
      (err, result) => {
        if(err){
          console.error(err);
          reject("Internal Server Error");
          return;
        }

        const id = uuidv4();

        db.query(`insert into transactions values(?, ?, ?, ?, ?)`, 
          [id, from_acc_no, to_acc_no, amount, new Date()], (err, result) => {

            if(err){
              console.error(err);
              reject("Internal Server Error");
              return;
            }

            db.commit();

            resolve(id);
        });

      });
    });
  });
}


module.exports = { verifyUser, verifyUserSecure, loginWithCredentials, 
    getUserDetails, updateBalancesAndRecord };
