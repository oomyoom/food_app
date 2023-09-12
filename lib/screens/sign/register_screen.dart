// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_app/screens/sign/components/signtitleText.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/inputField.dart';
import 'package:food_app/screens/sign/profilecreation_screen.dart';
import 'package:food_app/utils/tapButton.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailtextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final TextEditingController _confirmpasswordtextController =
      TextEditingController();

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
                      Icons.app_registration_outlined,
                      size: 100,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.05),
                        child: SigntitleText(
                            title: 'Create Your Account',
                            subtitle: 'Please enter your information')),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: InputField(
                        title: 'Email',
                        controller: _emailtextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: InputField(
                          title: 'Password',
                          controller: _passwordtextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: InputField(
                          title: 'Confirm-Password',
                          controller: _confirmpasswordtextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your confirm-password';
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
                            if (_formKey.currentState!.validate() &&
                                _passwordtextController.text.compareTo(
                                        _confirmpasswordtextController.text) ==
                                    0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Input is valid')));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfilecreationScreen()));
                            }
                          },
                          title: 'Sign Up',
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
