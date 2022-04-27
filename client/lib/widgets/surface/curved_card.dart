import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class CurvedCard extends StatelessWidget {
  final Widget child;
  final double margin;

  const CurvedCard({Key? key, required this.child, required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      decoration: BoxDecoration(
        color: ThemeConstant.colorSecondaryDark,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
