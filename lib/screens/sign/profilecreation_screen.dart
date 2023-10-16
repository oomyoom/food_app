import 'package:flutter/material.dart';
import 'package:food_app/screens/home/components/imageProfile.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/sign/login_screen.dart';
import 'package:food_app/utils/selectDate.dart';
import 'package:food_app/utils/tapButton.dart';

class ProfilecreationScreen extends StatefulWidget {
  const ProfilecreationScreen({Key? key}) : super(key: key);

  @override
  _ProfilecreationScreenState createState() => _ProfilecreationScreenState();
}

class _ProfilecreationScreenState extends State<ProfilecreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernametextController = TextEditingController();
  final TextEditingController _firstnametextController =
      TextEditingController();
  final TextEditingController _lastnametextController = TextEditingController();
  final TextEditingController _birthdaytextController = TextEditingController();

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
                    const ImageProfile(),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.05),
                        child: const SigntitleText(
                            title: 'Create Your Profile',
                            subtitle: 'Please enter your information')),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _usernametextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your gender';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(fontSize: 16)),
                        controller: _firstnametextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your firstname';
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
                              labelText: 'Last Name',
                              labelStyle: TextStyle(fontSize: 16)),
                          controller: _lastnametextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your lastname';
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: SelectDate(
                        title: 'Date of Birth',
                        controller: _birthdaytextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birthday';
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
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Input is valid')));
                              while (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            }
                          },
                          title: 'Complete',
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
