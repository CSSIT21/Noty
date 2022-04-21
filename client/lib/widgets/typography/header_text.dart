import 'package:flutter/material.dart';
import 'package:noty_client/types/widget/placement.dart';

Map<Size, double> sizeMapper = {
  Size.tiny: 10,
  Size.small: 14,
  Size.medium: 18,
  Size.large: 24,
};

class HeaderText extends StatelessWidget {
  final String text;
  final Size size;

  const HeaderText({Key? key, required this.text, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: sizeMapper[size], fontWeight: FontWeight.bold));
  }
}
