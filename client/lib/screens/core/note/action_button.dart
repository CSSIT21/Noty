import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/reminder/new_reminder.dart';

class NewNoteAction extends StatefulWidget {
  final String noteId;
  // final Function addNoteDetail;

  const NewNoteAction(
      {Key? key, required this.noteId /*, required this.addNoteDetail*/})
      : super(key: key);

  @override
  State<NewNoteAction> createState() => _NewNoteActionState();
}

class _NewNoteActionState extends State<NewNoteAction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Heading 1",
                style: TextStyle(
                  color: ThemeConstant.textColorPrimary,
                  fontSize: 16,
                ),
              ),
              Icon(
                CupertinoIcons.textformat,
                color: ThemeConstant.colorPrimaryLight,
                size: 30,
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Heading 2",
                style: TextStyle(
                  color: ThemeConstant.textColorPrimary,
                  fontSize: 16,
                ),
              ),
              Icon(
                CupertinoIcons.textformat,
                color: ThemeConstant.colorPrimaryLight,
                size: 24,
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Text",
                style: TextStyle(
                  color: ThemeConstant.textColorPrimary,
                  fontSize: 16,
                ),
              ),
              Icon(
                CupertinoIcons.textformat_abc,
                color: ThemeConstant.colorPrimaryLight,
                size: 24,
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reminder",
                style: TextStyle(
                  color: ThemeConstant.textColorPrimary,
                  fontSize: 16,
                ),
              ),
              Icon(
                CupertinoIcons.list_bullet,
                color: ThemeConstant.colorPrimaryLight,
                size: 24,
              )
            ],
          ),
        ),
      ],
      onSelected: (selected) {
        if (selected == 1) {
          // widget.addNoteDetail(widget.noteIndex, "h1");
        }
        if (selected == 2) {
          // widget.addNoteDetail(widget.noteIndex, "h2");
        }
        if (selected == 3) {
          // widget.addNoteDetail(widget.noteIndex, "note");
        }
        if (selected == 4) {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => const NewReminder(),
            expand: true,
          );
          // widget.addNoteDetail(widget.noteIndex, "reminder");
        }
      },
      color: const Color(0xff232323),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      offset: const Offset(0, -220),
      icon: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: ThemeConstant.colorPrimaryLight,
          shape: const StadiumBorder(),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.black),
      ),
    );
  }
}
