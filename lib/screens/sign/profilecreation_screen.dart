import 'package:flutter/material.dart';
import 'package:food_app/models/users.dart';
import 'dart:io';
import 'package:food_app/utils/imageHelper.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/selectDate.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;

class ProfilecreationScreen extends StatefulWidget {
  const ProfilecreationScreen({Key? key, required this.account})
      : super(key: key);
  final Account account;

  @override
  _ProfilecreationScreenState createState() => _ProfilecreationScreenState();
}

class _ProfilecreationScreenState extends State<ProfilecreationScreen> {
  File? _image;
  bool _hasImage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernametextController = TextEditingController();
  final TextEditingController _firstnametextController =
      TextEditingController();
  final TextEditingController _lastnametextController = TextEditingController();
  final TextEditingController _birthdaytextController = TextEditingController();
  final TextEditingController _phonenumbertextController =
      TextEditingController();

  Future<void> _onBackPressed() async {
    bool shouldNavigateBack = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ต้องการยกเลิกการสมัครสมาชิกใช่หรือไม่?'),
        actions: <Widget>[
          TextButton(
            child: const Text('ใช่'),
            onPressed: () {
              Navigator.of(context).pop(true); // คลิกใช่เพื่อออก
            },
          ),
          TextButton(
            child: const Text('ไม่'),
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

  Future<void> userCreation(
    File imageFile,
    String email,
    String password,
    String username,
    String firstname,
    String lastname,
    String phonenumber,
    String birthday,
  ) async {
    final url = Uri.parse('http://192.168.1.84:3333/auth/register');
    final request = http.MultipartRequest('POST', url);
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['username'] = username;
    request.fields['firstname'] = firstname;
    request.fields['lastname'] = lastname;
    request.fields['phonenumber'] = phonenumber;
    request.fields['birthday'] = birthday;

    request.files.add(http.MultipartFile(
      'image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: 'image.jpg',
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('สร้างบัญชีสำเร็จ'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    } else {
      // เกิดข้อผิดพลาดในการสร้างโปรไฟล์
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('สร้างบัญชีล้มเหลว'),
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
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      onTap: () async {
                        final imagefile =
                            await ImageProfileHelper().pickImage();
                        if (imagefile != null) {
                          final croppedFile = await ImageProfileHelper().crop(
                              file: imagefile, cropStyle: CropStyle.circle);
                          if (croppedFile != null) {
                            setState(() {
                              _image = File(croppedFile.path);
                              _hasImage = true;
                            });
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 72,
                        backgroundImage:
                            const AssetImage('assets/images/take_a_photo.png'),
                        backgroundColor: Colors.grey[300],
                        foregroundImage:
                            _image != null ? FileImage(_image!) : null,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.05),
                        child: const SigntitleText(
                            title: 'สร้างโปรไฟล์ของคุณ',
                            subtitle: 'โปรดกรอกข้อมูลของคุณ')),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'ชื่อผู้ใช้',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _usernametextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'โปรดกรอกชื่อผู้ใช้';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'ชื่อ',
                            labelStyle: TextStyle(fontSize: 16)),
                        controller: _firstnametextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดกรอกชื่อของคุณ';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'นามสกุล',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _lastnametextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'โปรดกรอกนามสกุลของคุณ';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'หมายเลขโทรศัพท์',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _phonenumbertextController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            final phonenumberRegex = RegExp(r'^[0-9]{10}$');
                            if (value == null || value.isEmpty) {
                              return 'โปรดกรอกหมายเลขโทรศัพท์ของคุณ';
                            }
                            if (!phonenumberRegex.hasMatch(value)) {
                              return 'กรุณาใส่หมายเลขโทรศัพท์ที่ถูกต้อง';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: SelectDate(
                        title: 'วันเกิด',
                        controller: _birthdaytextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'โปรดระบุวันเกิดของคุณ';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.03,
                        ),
                        child: TapButton(
                          press: () {
                            if (_hasImage &&
                                _formKey.currentState!.validate()) {
                              userCreation(
                                  _image!,
                                  widget.account.email,
                                  widget.account.password.trim(),
                                  _usernametextController.text,
                                  _firstnametextController.text,
                                  _lastnametextController.text,
                                  _phonenumbertextController.text,
                                  _birthdaytextController.text);
                            } else if (!_hasImage &&
                                _formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('โปรดเลือกรูปสำหรับใช้เป็นโปรไฟล์'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          title: 'เสร็จสิ้น',
                          color: kMainColor,
                        )),
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
