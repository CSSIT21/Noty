import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

showEditFolderDialog(BuildContext context, String folderName, int folderIndex) {
  TextEditingController _folderEditController =
      TextEditingController(text: folderName);

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData.dark(),
        child: CupertinoAlertDialog(
          title: Container(
            margin: const EdgeInsets.only(bottom: 14),
            child: const Text('Rename Folder'),
          ),
          content: Column(
            children: [
              CupertinoTextField(
                controller: _folderEditController,
                autofocus: true,
                placeholder: "Name",
                placeholderStyle: const TextStyle(
                  color: Color(0xff636367),
                ),
                style: TextStyle(
                    color: ThemeConstant.textColorPrimary, fontSize: 12),
              )
            ],
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                context
                    .read<NotesProvider>()
                    .editFolderName(folderIndex, _folderEditController.text);
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}
