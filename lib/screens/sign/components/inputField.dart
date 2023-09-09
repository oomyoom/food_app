import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: validator,
    );
  }
}
