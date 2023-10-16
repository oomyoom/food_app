const nodemailer = require("nodemailer");
const randomstring = require("randomstring");

const transporter = nodemailer.createTransport({
  host: "smtp-mail.outlook.com",
  port: 587,
  secure: false,
  auth: {
    user: "oomyoom_2545@hotmail.com",
    pass: "Herohon1",
  },
});

const verificationCodes = {};

// ส่งอีเมลยืนยัน
function sendVerificationEmail(email, callback) {
  const verificationCode = randomstring.generate(6);

  const mailOptions = {
    from: '"Unknow" <oomyoom_2545@hotmail.com>',
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

module.exports = {
  sendVerificationEmail,
  verifyEmail,
};
