import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/typography/content_text.dart';

class FolderListItem extends StatelessWidget {
  final String name;
  final int count;

  const FolderListItem({Key? key, required this.name, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.folder_rounded,
                  size: 26,
                  color: ThemeConstant.colorPrimaryLight,
                ),
              ),
              ContentText(text: name, size: Size.medium)
            ],
          ),
          Row(
            children: [
              Text(
                count.toString(),
                style: TextStyle(color: ThemeConstant.textColorSecondary),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: ThemeConstant.colorPrimaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
