import 'package:flutter/material.dart';

class ReminderLabel extends StatelessWidget {
  const ReminderLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff252525),
        borderRadius: BorderRadius.circular(5),
      ),
      width: 70,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 3),
            child: const Icon(
              Icons.format_list_bulleted_rounded,
              size: 10,
              color: Color(0xff828282),
            ),
          ),
          const Text(
            "Reminder",
            style: TextStyle(fontSize: 10, color: Color(0xff828282)),
          )
        ],
      ),
    );
  }
}
