
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';

TextEditingController _folderController = TextEditingController(text: '');

showNewFolderDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData.dark(),
        child: CupertinoAlertDialog(
          title: const Text('New folder'),
          content: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text('Enter a name for this folder.'),
              ),
              CupertinoTextField(
                controller: _folderController,
                placeholder: "Name",
                placeholderStyle: const TextStyle(
                  color: Color(0xff636367),
                ),
                style: TextStyle(color: ThemeConstant.textColorPrimary, fontSize: 12),
              )
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Save'),
              onPressed: () {
                // Do something destructive.
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}