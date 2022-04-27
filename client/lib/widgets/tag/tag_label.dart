import 'package:flutter/material.dart';

class TagLabel extends StatelessWidget {
  final Color textColor;
  final Color bgColor;
  final String title;
  final bool iconFilled;
  const TagLabel(
      {Key? key,
      required this.textColor,
      required this.bgColor,
      required this.title,
      required this.iconFilled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 3),
            child: Icon(
              iconFilled ? Icons.sell_rounded : Icons.sell_outlined,
              size: 10,
              color: textColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 10, color: textColor),
          )
        ],
      ),
    );
  }
}
