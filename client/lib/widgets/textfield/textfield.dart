import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class TextFieldDark extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const TextFieldDark(
      {Key? key, required this.controller, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: ThemeConstant.textFieldTextColor),
          filled: true,
          fillColor: ThemeConstant.textFieldBgColor),
    );
  }
}
