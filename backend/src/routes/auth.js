// routers/auth.js
const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { db } = require("../config/database"); // นำเข้าฐานข้อมูล
const { secretKey } = require("../config/config"); // นำเข้าคีย์ลับจากไฟล์ config

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
