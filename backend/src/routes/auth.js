// routers/auth.js
const express = require("express");
const router = express.Router();
const { db } = require("../config/database"); // นำเข้าฐานข้อมูล
const {
  sendVerificationEmail,
  verifyEmail,
  createUser,
  login,
} = require("../controllers/authOperations");
const multer = require("multer");

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

router.post("/send-verification", (req, res) => {
  const { email } = req.body;

  sendVerificationEmail(email, (error, message) => {
    if (error) {
      console.log(error);
      res.status(500).send("ข้อผิดพลาดในการส่งอีเมลยืนยัน");
    } else {
      res.status(200).send(message);
    }
  });
});

router.post("/verify-email", (req, res) => {
  const { email, verificationCode } = req.body;

  verifyEmail(email, verificationCode, (error, message) => {
    if (error) {
      res.status(400).send(message); // รหัสยืนยันไม่ถูกต้อง
    } else {
      res.status(200).send(message); // ยืนยันอีเมลสำเร็จ
    }
  });
});

// โค้ดสำหรับลงทะเบียนผู้ใช้
router.post("/register", upload.single("image"), async (req, res) => {
  try {
    const checkEmailQuery = "SELECT * FROM users WHERE email = ?";
    const [existingUsers] = await db.promise().query(checkEmailQuery, [email]);

    if (existingUsers.length > 0) {
      return res.status(400).json({ error: "Email นี้มีอยู่ในระบบแล้ว" });
    }

    const { email, password, username, firstname, lastname, birthday } =
      req.body; // Get other data
    const image = req.file.buffer; // Get the image buffer

    await db
      .promise()
      .query(
        "INSERT INTO users (email, password, image, username, firstname, lastname, birthday) VALUES (?, ?, ?, ?, ?, ?, ?)",
        [email, password, image, username, firstname, lastname, birthday]
      );

    res.status(200).send("Data and image uploaded successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error uploading data and image");
  }
});

// โค้ดสำหรับเข้าสู่ระบบ
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const result = await login(email, password);

    if (result.token) {
      res.status(200).json(result);
    } else {
      res.status(401).json(result);
    }
  } catch (err) {
    console.error("เกิดข้อผิดพลาดในการเข้าสู่ระบบ: " + err);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการเข้าสู่ระบบ" });
  }
});

module.exports = router;
