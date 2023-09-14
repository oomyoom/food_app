import 'package:flutter/material.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({
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
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      decoration: InputDecoration(
        labelText: title,
      ),
      validator: validator,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != controller.text) {
      controller.text = picked.toString().split(' ')[0];
    }
  }
}
