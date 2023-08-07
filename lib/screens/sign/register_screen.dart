// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_app/screens/sign/components/inputField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _setState = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: bodyBuilder());
  }

  Widget bodyBuilder() {
    switch (_setState) {
      case 0:
        return registerPersonalForm();
      case 1:
        return registerForm();
      default:
        return registerPersonalForm();
    }
  }

  SafeArea registerPersonalForm() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.app_registration_outlined,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Text(
                      'Create Your Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    SizedBox(
                      height: 10,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: InputField(title: 'First Name'),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: InputField(
                    title: 'Last Name',
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: InputField(
                    title: 'Date of Birth',
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: InputField(
                    title: 'Gender',
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    setState(() {
                      _setState++;
                    });
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SafeArea registerForm() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.app_registration_outlined,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Text(
                      'Create Your Account',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
                    ),
                    SizedBox(
                      height: 10,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: InputField(title: 'Username'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: InputField(title: 'Email'),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: InputField(
                    title: 'Password',
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: InputField(
                    title: 'Confirm-Password',
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
