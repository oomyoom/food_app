const express = require("express");
const router = express.Router();
const userProfileRetrieval = require("../controllers/userProfileRetrieval");
const multer = require("multer");
const { db } = require("../config/database");
const { verifyToken } = require("../middlewares/authToken"); // นำเข้า middleware

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

router.get("/get", verifyToken, async (req, res) => {
  try {
    const user = await userProfileRetrieval.retrieveUserProfile(req.uid);
    res.status(200).json(user);
  } catch (error) {
    console.error("เกิดข้อผิดพลาดในการดึงข้อมูล:", error);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการดึงข้อมูล" });
  }
});

router.put("/update", upload.single("image"), async (req, res) => {
  try {
    const { username, firstname, lastname } = req.body; // Get other data
    const image = req.file.buffer; // Get the image buffer

    await db
      .promise()
      .query(
        "UPDATE users SET image = ?, username = ?, firstname = ?, lastname = ? WHERE uid = 1",
        [image, username, firstname, lastname]
      );

    res.status(200).send("Data and image uploaded successfully");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error uploading data and image");
  }
});

module.exports = router;
