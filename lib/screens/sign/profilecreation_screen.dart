import 'package:flutter/material.dart';
import 'package:food_app/imageProfile.dart';
import 'package:food_app/screens/sign/components/inputField.dart';
import 'package:food_app/screens/sign/login_screen.dart';
import 'package:food_app/tapButton.dart';

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
                  ImageProfile(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      children: [
                        Text(
                          'Create Your Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          'Please enter your information',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: InputField(
                        title: 'Username',
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
                    child: InputField(
                      title: 'First Name',
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
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: InputField(
                        title: 'Last Name',
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
                      child: InputField(
                        title: 'Date of Birth',
                        controller: _birthdaytextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your birthday';
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
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Input is valid')));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          }
                        },
                        title: 'Complete',
                        color: Color.fromARGB(255, 66, 118, 93),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
