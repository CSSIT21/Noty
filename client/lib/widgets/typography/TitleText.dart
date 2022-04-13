// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}
