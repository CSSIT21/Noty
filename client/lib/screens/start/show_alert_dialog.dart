import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error!'),
      backgroundColor: ThemeConstant.colorSecondaryDark,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: TextStyle(color: ThemeConstant.colorPrimaryLight),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
