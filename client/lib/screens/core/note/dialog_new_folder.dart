import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:provider/provider.dart';

TextEditingController _folderController = TextEditingController(text: '');

showNewFolderDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return Theme(
        data: ThemeData.dark(),
        child: CupertinoAlertDialog(
          title: const Text('New Folder'),
          content: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text('Enter a name for this folder.'),
              ),
              CupertinoTextField(
                controller: _folderController,
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
                _folderController.text = "";
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                if (_folderController.text.isEmpty) {
                  var error = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin:
                        const EdgeInsets.only(bottom: 40, left: 15, right: 15),
                    content: const Text("Folder name cannot be empty"),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(error);
                } else {
                  context
                      .read<NotesProvider>()
                      .addFolder(_folderController.text, context)
                      .then((_) {
                    Navigator.pop(context);
                    _folderController.text = "";
                  });
                }
              },
            )
          ],
        ),
      );
    },
  );
}
