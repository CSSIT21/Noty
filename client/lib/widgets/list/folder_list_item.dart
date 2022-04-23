import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class FolderListItem extends StatelessWidget {
  final String title;
  final int count;

  const FolderListItem({Key? key, required this.title, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
              SizedBox(
                width: screenWidth / 1.8,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
                  size: 14,
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
