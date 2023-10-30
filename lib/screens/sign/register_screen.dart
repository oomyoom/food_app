// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/models/users.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/screens/sign/emailVerify_screen.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailtextController = TextEditingController();
  final _passwordtextController = TextEditingController();
  final _confirmpasswordtextController = TextEditingController();

  Future<void> checkExistingEmail() async {
    final email = _emailtextController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/existingemail'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      // ส่งสำเร็จ
      final account = Account(
          email: _emailtextController.text,
          password: _passwordtextController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => EmailVerifyScreen(
                    account: account,
                  )));
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('บัญชีนี้มีอยู่ในระบบแล้ว'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
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
                      Icons.app_registration_outlined,
                      size: 100,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.05),
                        child: SigntitleText(
                            title: 'สร้างบัญชีของคุณ',
                            subtitle: 'โปรดกรอกข้อมูลของคุณ')),
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
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (value == null || value.isEmpty) {
                            return 'โปรดกรอกอีเมลของคุณ';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'กรุณาใส่อีเมลที่ถูกต้อง';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'รหัสผ่าน',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _passwordtextController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'โปรดสร้างรหัสผ่านของคุณ';
                            }
                            // if (value.length < 8) {
                            //   return 'รหัสผ่านจำเป็นต้องมีความยาวอย่างน้อย 8 ตัวอักษร';
                            // }
                            return null;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'ยืนยันรหัสผ่าน',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _confirmpasswordtextController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'โปรดกรอกยืนยันรหัสผ่าน';
                            }
                            if (_passwordtextController.text.compareTo(
                                    _confirmpasswordtextController.text) !=
                                0) {
                              return 'รหัสผ่านไม่ตรงกัน';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                        ),
                        child: TapButton(
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              checkExistingEmail();
                            }
                          },
                          title: 'สมัครสมาชิก',
                          color: kMainColor,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
