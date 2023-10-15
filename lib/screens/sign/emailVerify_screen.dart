import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/screens/sign/login_screen.dart';
import 'dart:convert';

class EmailVerifyScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final verificationCodeController = TextEditingController();

  Future<void> sendVerificationEmail() async {
    final email = emailController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/send-verification'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      // ส่งอีเมลยืนยันสำเร็จ
    } else {
      // เกิดข้อผิดพลาดในการส่งอีเมลยืนยัน
    }
  }

  Future<void> verifyEmail(BuildContext context) async {
    final email = emailController.text;
    final verificationCode = verificationCodeController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/verify-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'verificationCode': verificationCode}),
    );

    if (response.statusCode == 200) {
      // ยืนยันอีเมลสำเร็จ
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      // รหัสยืนยันไม่ถูกต้อง
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: sendVerificationEmail,
              child: Text('ส่งอีเมลยืนยัน'),
            ),
            TextField(
              controller: verificationCodeController,
              decoration: InputDecoration(labelText: 'รหัสยืนยัน'),
            ),
            ElevatedButton(
              onPressed: () => verifyEmail(context),
              child: Text('ยืนยันอีเมล'),
            ),
          ],
        ),
      ),
    );
  }
}
