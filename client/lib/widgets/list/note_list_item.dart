import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/widgets/reminder/reminder_label.dart';
import 'package:noty_client/widgets/tag/tag_label.dart';

class NoteListItem extends StatelessWidget {
  final String name;
  final String date;
  final bool reminder;
  final bool tag;
  const NoteListItem(
      {Key? key,
      required this.name,
      required this.date,
      required this.reminder,
      required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 3, 20, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    date,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ),
                Row(
                  children: [
                    reminder
                        ? Container(
                            child: const ReminderLabel(),
                            margin: const EdgeInsets.only(right: 6),
                          )
                        : Container(),
                    tag ? const TagLabel() : Container(),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: ThemeConstant.colorPrimaryLight,
          ),
        ],
      ),
    );
  }
}
