import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/note/dialog_new_folder.dart';

Widget menuPopup(BuildContext context) => PopupMenuButton(
  itemBuilder: (context) => [
    PopupMenuItem(
      value: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "New Folder",
            style: TextStyle(
              color: ThemeConstant.textColorPrimary,
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.folder_rounded,
            color: ThemeConstant.colorPrimaryLight,
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
            "New Note",
            style: TextStyle(
              color: ThemeConstant.textColorPrimary,
              fontSize: 16,
            ),
          ),
          Icon(
            Icons.edit_note_rounded,
            color: ThemeConstant.colorPrimaryLight,
            size: 24,
          )
        ],
      ),
    ),
  ],
  onSelected: (selected) {
    if (selected == 1) {
      showNewFolderDialog(context);
    }
  },
  color: const Color(0xb36ABFF9),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  offset: const Offset(0, -120),
  icon: Container(
    height: double.infinity,
    width: double.infinity,
    decoration: ShapeDecoration(
      color: ThemeConstant.colorPrimaryLight,
      shape: const StadiumBorder(),
    ),
    child: const Icon(Icons.add_rounded, color: Colors.white),
  ),
);