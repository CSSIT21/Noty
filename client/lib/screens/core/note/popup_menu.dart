import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/note/dialog_new_folder.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/services/notification_sevice.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

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
                CupertinoIcons.folder_fill,
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
                CupertinoIcons.pencil_outline,
                color: ThemeConstant.colorPrimaryLight,
                size: 24,
              )
            ],
          ),
        ),
      ],
      onSelected: (selected) async {
        if (selected == 1) {
          NotificationService.showNotification(
              title: "Reminder",
              body: "This is a notification from add folder button",
              payload: "test");
          showNewFolderDialog(context);
        }
        if (selected == 2) {
          await context
              .read<NotesProvider>()
              .addNote("", context)
              .then((response) {
            if (response != false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(
                        previousScreen: "All Notes",
                        noteId: response,
                        noteTitle: "Untitled") //     ),
                    ),
              );
            }
          });
        }
      },
      color: const Color(0xff232323),
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
        child: const Icon(Icons.add_rounded, color: Colors.black),
      ),
    );
