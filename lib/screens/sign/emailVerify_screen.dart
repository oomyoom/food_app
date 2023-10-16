import 'package:flutter/material.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/screens/sign/profilecreation_screen.dart';
import 'dart:convert';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _EmailVerifyScreenState createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final _verificationCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _onBackPressed() async {
    bool shouldNavigateBack = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ต้องการยกเลิกการสมัครสมาชิกใช่หรือไม่?'),
        actions: <Widget>[
          TextButton(
            child: Text('ใช่'),
            onPressed: () {
              Navigator.of(context).pop(true); // คลิกใช่เพื่อออก
            },
          ),
          TextButton(
            child: Text('ไม่'),
            onPressed: () {
              Navigator.of(context).pop(false); // คลิกไม่เพื่อยกเลิก
            },
          ),
        ],
      ),
    );
    if (shouldNavigateBack) {
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> sendVerificationEmail(BuildContext context) async {
    final email = widget.email;

    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/send-verification'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      // ส่งอีเมลยืนยันสำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('การยืนยันอีเมลสำเร็จ'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    } else {
      // เกิดข้อผิดพลาดในการส่งอีเมลยืนยัน
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('การยืนยันอีเมลสำเร็จ'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    }
  }

  Future<void> verifyEmail(BuildContext context) async {
    final email = widget.email;
    final verificationCode = _verificationCodeController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.84:3333/auth/verify-email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'verificationCode': verificationCode}),
    );

    if (response.statusCode == 200) {
      // ยืนยันอีเมลสำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('การยืนยันอีเมลสำเร็จ'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const ProfilecreationScreen()));
    } else {
      // รหัสยืนยันไม่ถูกต้อง
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('รหัสยืนยันไม่ถูกต้อง'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed();
        return false;
      },
      child: Scaffold(
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
                            title: 'Email Verification',
                            subtitle: 'Please enter your code')),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              enabled: false,
                              initialValue: widget.email,
                              decoration: InputDecoration(
                                labelText: 'อีเมล',
                                labelStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              sendVerificationEmail(context);
                            },
                            child: Text('ส่งอีเมลยืนยัน'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kMainColor),
                              fixedSize: MaterialStateProperty.all(Size(
                                MediaQuery.of(context).size.width * 0.28,
                                MediaQuery.of(context).size.height * 0.05,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'รหัสยืนยัน',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _verificationCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'โปรดใส่รหัสยืนยันของคุณ';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: TapButton(
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            verifyEmail(context);
                          }
                        },
                        title: 'ยืนยันอีเมล',
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
