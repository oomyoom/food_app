const nodemailer = require("nodemailer");
const randomstring = require("randomstring");
const bcrypt = require("bcrypt");
const fs = require("fs");
const { DateTime } = require("luxon");
const jwt = require("jsonwebtoken");
const { db } = require("../config/database");
const { secretKey } = require("../config/config");

// คนส่งเมล
const transporter = nodemailer.createTransport({
  host: "smtp-mail.outlook.com",
  port: 587,
  secure: false,
  auth: {
    user: "oomy_2545@hotmail.com",
    pass: "Oom741190",
  },
});

const verificationCodes = {};

// ส่งอีเมลยืนยัน
function sendVerificationEmail(email, callback) {
  const verificationCode = randomstring.generate(6);

  const mailOptions = {
    from: '"Unknow" <oomy_2545@hotmail.com>',
    to: email,
    subject: "ยืนยันอีเมล",
    text: `รหัสยืนยันของคุณคือ: ${verificationCode}`,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      callback(error);
    } else {
      verificationCodes[email] = verificationCode;
      callback(null, "อีเมลยืนยันถูกส่ง");
    }
  });
}

// ยืนยันอีเมล
function verifyEmail(email, verificationCode, callback) {
  if (
    verificationCodes[email] &&
    verificationCodes[email] === verificationCode
  ) {
    delete verificationCodes[email];
    callback(null, "ยืนยันอีเมลสำเร็จ");
  } else {
    callback("รหัสยืนยันไม่ถูกต้อง");
  }
}

// แปลงรูป
async function saveImage(base64Image) {
  const imageBuffer = Buffer.from(base64Image, "base64");
  const imagePathToSave = "./src/models/images/profile.png";
  fs.writeFileSync(imagePathToSave, imageBuffer);
  return imagePathToSave;
}

// Format วันเกิด
function formatBirthday(birthday) {
  return DateTime.fromISO(birthday).toFormat("yyyy-MM-dd HH:mm:ss");
}

// สร้าง user
async function createUser(
  email,
  password,
  base64Image,
  username,
  firstname,
  lastname,
  birthday,
  callback
) {
  const imagePathToSave = await saveImage(base64Image);
  const dateTime = formatBirthday(birthday);

  const hashedPassword = await bcrypt.hash(password, 10);

  const insertQuery =
    "INSERT INTO users (email, password, image, username, firstname, lastname, birthday) VALUES (?, ?, ?, ?, ?, ?, ?)";

  db.query(
    insertQuery,
    [
      email,
      hashedPassword,
      imagePathToSave,
      username,
      firstname,
      lastname,
      dateTime,
    ],
    (error, results) => {
      if (error) {
        console.error("Error inserting data into user:" + error);
        callback(error);
      } else {
        console.log("Data inserted into user:", results);
        callback(null);
        // ลบไฟล์รูปภาพหลังจากบันทึกลงในฐานข้อมูลแล้ว
      }
    }
  );
}

async function login(email, password) {
  const query = "SELECT * FROM users WHERE email = ?";
  const [results] = await db.promise().query(query, [email]);

  if (results.length > 0) {
    const user = results[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (isMatch) {
      const token = jwt.sign({ uid: user.uid }, secretKey, {
        expiresIn: "365d",
      });
      return { token };
    } else {
      return { error: "รหัสผ่านไม่ถูกต้อง" };
    }
  } else {
    return { error: "ไม่พบผู้ใช้" };
  }
}

module.exports = {
  sendVerificationEmail,
  verifyEmail,
  createUser,
  login,
};
