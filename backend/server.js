const express = require("express");
const cors = require("cors");
const { verifyToken } = require("./src/middlewares/authToken"); // นำเข้า middleware

const app = express();
const port = 3333;

app.use(express.json());
app.use(cors());

// นำเข้าและใช้งาน routers
const authRouter = require("./src/routes/auth");
app.use("/auth", authRouter);

app.get("/protected", verifyToken, (req, res) => {
  res.json({ message: "คุณเข้าถึงเส้นทางที่คุ้มครองแล้ว" });
});

const menu = require("./src/routes/menuController");
app.use("/", menu);

app.listen(port, () => {
  console.log(`เซิร์ฟเวอร์ทำงานที่พอร์ต ${port}`);
});
