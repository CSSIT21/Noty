import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class CurvedCard extends StatelessWidget {
  final Widget child;

  const CurvedCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: ThemeConstant.colorSecondaryDark,
          borderRadius: BorderRadius.circular(10),
        ),
      child: child,
    );
  }
}
