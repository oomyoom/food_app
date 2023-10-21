// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_app/models/order.dart';
import 'package:food_app/models/users.dart';
import 'package:food_app/utils/buttomTab.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/sign/register_screen.dart';
import 'package:food_app/utils/decodeJWT.dart';
import 'package:food_app/utils/tapButton.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailtextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwt_token', token);
  }

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': _emailtextController.text, // แทนด้วยอีเมลของผู้ใช้
        'password': _passwordtextController.text, // แทนด้วยรหัสผ่านของผู้ใช้
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String token = data['token']; // รับโทเคน JWT จากการตอบกลับ

      // บันทึก token ลงใน local storage
      await saveToken(token);
      decodedToken();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('เข้าสู่ระบบสำเร็จ'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
      await convertProfile();
      await convertAllOrder();
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ButtomTab(
                    initialIndex: 0,
                  )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('เข้าสู่ระบบล้มเหลว'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_outlined,
                    size: 100,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.05),
                      child: SigntitleText(
                          title: "ยินดีต้อนรับ",
                          subtitle:
                              'เรามุ่งสู่อร่อยที่สุดและคุณคือส่วนสำคัญในนี้')),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'อีเมล',
                          labelStyle: TextStyle(fontSize: 16)),
                      controller: _emailtextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'โปรดระบุอีเมลของคุณ';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'รหัสผ่าน',
                            labelStyle: TextStyle(fontSize: 16)),
                        controller: _passwordtextController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุรหัสผ่านของคุณ';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03),
                      child: TapButton(
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            loginUser();
                          }
                        },
                        title: 'เข้าสู่ระบบ',
                        color: kMainColor,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'มีสมาชิกหรือยัง?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterScreen()),
                            );
                          },
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
