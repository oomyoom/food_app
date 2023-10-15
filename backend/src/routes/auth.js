// routers/auth.js
const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const nodemailer = require("nodemailer");
const randomstring = require("randomstring");
const { db } = require("../config/database"); // นำเข้าฐานข้อมูล
const { secretKey } = require("../config/config"); // นำเข้าคีย์ลับจากไฟล์ config

// สร้างอีเมลเซสชัน
const transporter = nodemailer.createTransport({
  host: "smtp-mail.outlook.com", // ใช้ SMTP server ของ Hotmail (Outlook)
  port: 587, // พอร์ตสำหรับ SMTP
  secure: false, // เปิดใช้งานการเชื่อมต่อไม่ปลอดภัย
  auth: {
    user: "oomyoom_2545@hotmail.com", // ใส่อีเมล Hotmail (Outlook) ของคุณ
    pass: "Herohon1", // ใส่รหัสผ่าน Hotmail (Outlook) ของคุณ
  },
});

// เก็บรหัสยืนยันและอีเมลในออบเจ็กต์
const verificationCodes = {};

router.post("/send-verification", (req, res) => {
  const { email } = req.body;
  const verificationCode = randomstring.generate(6); // สร้างรหัสยืนยัน 6 ตัว

  // ส่งอีเมลยืนยัน
  const mailOptions = {
    from: '"Unknow" <oomyoom_2545@hotmail.com>',
    to: email,
    subject: "ยืนยันอีเมล",
    text: `รหัสยืนยันของคุณคือ: ${verificationCode}`,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.log(error);
      res.status(500).send("ข้อผิดพลาดในการส่งอีเมลยืนยัน");
    } else {
      // เก็บรหัสยืนยันไว้ในออบเจ็กต์และส่งให้ผู้ใช้
      verificationCodes[email] = verificationCode;
      res.status(200).send("อีเมลยืนยันถูกส่ง");
    }
  });
});

router.post("/verify-email", (req, res) => {
  const { email, verificationCode } = req.body;

  if (
    verificationCodes[email] &&
    verificationCodes[email] === verificationCode
  ) {
    // ยืนยันอีเมลสำเร็จ
    res.status(200).send("ยืนยันอีเมลสำเร็จ");
    delete verificationCodes[email]; // ลบรหัสยืนยันหลังจากใช้งาน
  } else {
    // รหัสยืนยันไม่ถูกต้อง
    res.status(400).send("รหัสยืนยันไม่ถูกต้อง");
  }
});

// โค้ดสำหรับลงทะเบียนผู้ใช้
router.post("/register", async (req, res) => {
  const { email, password, name } = req.body;

  try {
    // ตรวจสอบความถูกต้องของข้อมูล
    if (!email || !password || !name) {
      return res.status(400).json({ error: "กรุณากรอกข้อมูลทั้งหมด" });
    }

    // เช็คว่า email ซ้ำหรือไม่
    const checkEmailQuery = "SELECT * FROM users WHERE email = ?";
    const [existingUsers] = await db.promise().query(checkEmailQuery, [email]);

    if (existingUsers.length > 0) {
      return res.status(400).json({ error: "Email นี้มีอยู่ในระบบแล้ว" });
    }

    // เข้ารหัสรหัสผ่าน
    const hashedPassword = await bcrypt.hash(password, 10);

    const insertQuery =
      "INSERT INTO users (email, password, name) VALUES (?, ?, ?)";
    await db.promise().execute(insertQuery, [email, hashedPassword, name]);

    res.json({ message: "ลงทะเบียนผู้ใช้สำเร็จ" });
  } catch (err) {
    console.error("เกิดข้อผิดพลาดในการลงทะเบียนผู้ใช้: " + err);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการลงทะเบียนผู้ใช้" });
  }
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
