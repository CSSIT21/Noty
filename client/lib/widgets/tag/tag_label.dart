import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class TagLabel extends StatelessWidget {
  final String title;
  final bool iconFilled;
  final bool isSelected;
  const TagLabel(
      {Key? key,
      required this.title,
      required this.iconFilled,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeConstant.colorPrimaryLight
            : const Color(0xff252525),
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
              color: isSelected
                  ? ThemeConstant.textColorPrimary
                  : const Color(0xff828282),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: isSelected
                  ? ThemeConstant.textColorPrimary
                  : const Color(0xff828282),
            ),
          )
        ],
      ),
    );
  }
}
