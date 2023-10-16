// routers/auth.js
const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { db } = require("../config/database"); // นำเข้าฐานข้อมูล
const { secretKey } = require("../config/config"); // นำเข้าคีย์ลับจากไฟล์ config
const {
  sendVerificationEmail,
  verifyEmail,
} = require("../controllers/authOperations");
const fs = require("fs");
const { DateTime } = require("luxon");

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
router.post("/register", async (req, res) => {
  const {
    email,
    password,
    base64Image,
    username,
    firstname,
    lastname,
    birthday,
  } = req.body;

  const imageBuffer = Buffer.from(base64Image, "base64");
  const imagePathToSave = "./src/models/images/profile.jpg";
  fs.writeFileSync(imagePathToSave, imageBuffer);

  const dateTime = DateTime.fromISO(birthday).toFormat("yyyy-MM-dd HH:mm:ss");

  // เช็คว่า email ซ้ำหรือไม่
  const checkEmailQuery = "SELECT * FROM users WHERE email = ?";
  const [existingUsers] = await db.promise().query(checkEmailQuery, [email]);

  if (existingUsers.length > 0) {
    return res.status(400).json({ error: "Email นี้มีอยู่ในระบบแล้ว" });
  }

  // เข้ารหัสรหัสผ่าน
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
    (err, result) => {
      if (err) {
        console.error("เกิดข้อผิดพลาดในการบันทึกข้อมูล: " + err);
        res.status(500).json({ message: "สร้างบัญชีล้มเหลว" });
      } else {
        res.status(200).json({ message: "สร้างบัญชีสำเร็จ" });
        // ลบไฟล์รูปภาพหลังจากบันทึกลงในฐานข้อมูลแล้ว
        fs.unlink(imagePathToSave, (err) => {
          if (err) {
            console.error("เกิดข้อผิดพลาดในการลบไฟล์: " + err);
          } else {
            console.log("ลบไฟล์รูปภาพเรียบร้อย");
          }
        });
      }
    }
  );
});

// โค้ดสำหรับเข้าสู่ระบบ
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    // ค้นหาผู้ใช้จากฐานข้อมูล
    const query = "SELECT * FROM users WHERE email = ?";
    const [results] = await db.promise().query(query, [email]);
    console.log(results);

    if (results.length > 0) {
      const user = results[0];
      // ตรวจสอบรหัสผ่าน
      const isMatch = await bcrypt.compare(password, user.password);

      if (isMatch) {
        // สร้าง JWT
        const token = jwt.sign({ id: user.id }, secretKey, {
          expiresIn: "1h",
        });
        res.json({ token });
      } else {
        res.status(401).json({ error: "รหัสผ่านไม่ถูกต้อง" });
      }
    } else {
      res.status(401).json({ error: "ไม่พบผู้ใช้" });
    }
  } catch (err) {
    console.error("เกิดข้อผิดพลาดในการเข้าสู่ระบบ: " + err);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการเข้าสู่ระบบ" });
  }
});

module.exports = router;
