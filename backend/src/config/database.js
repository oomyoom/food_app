// middlewares/database.js
const mysql = require("mysql2");

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

module.exports = {
  db,
};
