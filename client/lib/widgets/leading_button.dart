import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

class LeadingButton extends StatelessWidget {
  final String text;
  const LeadingButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: ThemeConstant.colorPrimaryLight,
            ),
            SizedBox(
              width: 60,
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 17, color: ThemeConstant.colorPrimaryLight),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
