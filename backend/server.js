const express = require("express");
const mysql = require("mysql2");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const cors = require("cors");
const secretKey = "olo";

const app = express();
const port = 3333;

app.use(express.json());
app.use(cors());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  database: "food_app",
});

db.connect((err) => {
  if (err) {
    console.error("เกิดข้อผิดพลาดในการเชื่อมต่อกับ MySQL2: " + err);
  } else {
    console.log("เชื่อมต่อกับ MySQL2 สำเร็จ");
  }
});

app.post("/register", (req, res) => {
  const { email, password, name } = req.body;

  // เข้ารหัสรหัสผ่านก่อนบันทึกลงในฐานข้อมูล
  bcrypt.hash(password, 10, (err, hashedPassword) => {
    if (err) {
      console.error("เกิดข้อผิดพลาดในการเข้ารหัสรหัสผ่าน: " + err);
      return res
        .status(500)
        .json({ error: "เกิดข้อผิดพลาดในการลงทะเบียนผู้ใช้" });
    }

    const insertQuery =
      "INSERT INTO users (email, password, name) VALUES (?, ?, ?)";
    db.promise()
      .execute(insertQuery, [email, hashedPassword, name])
      .then(() => {
        res.json({ message: "ลงทะเบียนผู้ใช้สำเร็จ" });
      })
      .catch((err) => {
        console.error("เกิดข้อผิดพลาดในการลงทะเบียนผู้ใช้: " + err);
        res.status(500).json({ error: "เกิดข้อผิดพลาดในการลงทะเบียนผู้ใช้" });
      });
  });
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;

  const query = "SELECT * FROM users WHERE email = ?";
  db.promise()
    .query(query, [email])
    .then(([results]) => {
      if (results.length > 0) {
        const user = results[0];
        // ตรวจสอบรหัสผ่านในฐานข้อมูล
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if (err) {
            console.error("เกิดข้อผิดพลาดในการตรวจสอบรหัสผ่าน: " + err);
            return res
              .status(500)
              .json({ error: "เกิดข้อผิดพลาดในการเข้าสู่ระบบ" });
          }
          if (isMatch) {
            // สร้าง JWT
            const token = jwt.sign({ id: user.id }, secretKey, {
              expiresIn: "1h",
            });
            res.json({ token });
          } else {
            res.status(401).json({ error: "รหัสผ่านไม่ถูกต้อง" });
          }
        });
      } else {
        res.status(401).json({ error: "ไม่พบผู้ใช้" });
      }
    })
    .catch((err) => {
      console.error("เกิดข้อผิดพลาดในการค้นหาผู้ใช้: " + err);
      res.status(500).json({ error: "เกิดข้อผิดพลาดในการเข้าสู่ระบบ" });
    });
});

app.get("/protected", verifyToken, (req, res) => {
  res.json({ message: "คุณเข้าถึงเส้นทางที่คุ้มครองแล้ว" });
});

function verifyToken(req, res, next) {
  const token = req.headers.authorization.split(" ")[1];
  console.log(token);

  if (!token) {
    return res.status(403).json({ error: "ไม่มี Token ในการเข้าถึง" });
  }

  jwt.verify(token, secretKey, (err, decoded) => {
    if (err) {
      return res.status(401).json({ error: "Token ไม่ถูกต้อง" });
    }
    req.userId = decoded.id;
    next();
  });
}

app.listen(port, () => {
  console.log(`เซิร์ฟเวอร์ทำงานที่พอร์ต ${port}`);
});
