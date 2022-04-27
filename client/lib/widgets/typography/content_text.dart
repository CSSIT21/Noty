import 'package:flutter/material.dart';
import 'package:noty_client/types/widget/placement.dart';

Map<Size, double> sizeMapper = {
  Size.tiny: 10,
  Size.small: 12,
  Size.medium: 14,
  Size.large: 16,
};

class ContentText extends StatelessWidget {
  final String text;
  final Size size;

  const ContentText({Key? key, required this.text, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: sizeMapper[size]));
  }
}
