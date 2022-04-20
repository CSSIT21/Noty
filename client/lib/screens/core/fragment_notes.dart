import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/widgets/list/folder_list_item.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class NotesFragment extends StatefulWidget {
  const NotesFragment({Key? key}) : super(key: key);

  @override
  State<NotesFragment> createState() => _NotesFragmentState();
}

class _NotesFragmentState extends State<NotesFragment> {
  late TextEditingController _folderController;
  List<Folder> folders = [];
  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/folders.json');
    final List<dynamic> datas = await json.decode(response);
    List<Folder> temp = datas.map((data) {
      return Folder(id: data["id"], name: data["name"], count: data["count"]);
    }).toList();
    setState(() {
      folders = temp;
    });
  }

  @override
  void initState() {
    super.initState();
    _folderController = TextEditingController(text: '');
  }

  showDialog() {
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
                  style: TextStyle(
                      color: ThemeConstant.textColorPrimary, fontSize: 12),
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

  Widget _menuPopup() => PopupMenuButton(
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
            showDialog();
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

  @override
  Widget build(BuildContext context) {
    _readJson();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const HeaderText(text: "Folders"),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: ThemeConstant.colorSecondaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    for (var folder in folders)
                      Column(
                        children: [
                          folder.id != folders[0].id
                              ? const Divider(
                                  color: Color(0xff434345),
                                  indent: 50,
                                )
                              : Container(),
                          FolderListItem(
                              name: folder.name, count: folder.count),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                child: const HeaderText(text: "Notes"),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                  color: ThemeConstant.colorSecondaryDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: const [
                    NoteListItem(
                      name: "IEEE Spectrum",
                      date: "18/03/2022",
                      reminder: true,
                      tag: true,
                    ),
                    Divider(
                      color: Color(0xff434345),
                      indent: 25,
                    ),
                    NoteListItem(
                      name: "12345678901234567890123456aaasss",
                      date: "18/03/2022",
                      reminder: false,
                      tag: true,
                    ),
                    Divider(
                      color: Color(0xff434345),
                      indent: 25,
                    ),
                    NoteListItem(
                      name: "Just a simple note",
                      date: "18/03/2022",
                      reminder: true,
                      tag: false,
                    ),
                    Divider(
                      color: Color(0xff434345),
                      indent: 25,
                    ),
                    NoteListItem(
                      name: "Hate Flutter",
                      date: "18/03/2022",
                      reminder: false,
                      tag: false,
                    ),
                    Divider(
                      color: Color(0xff434345),
                      indent: 25,
                    ),
                    NoteListItem(
                      name: "Hate Flutter",
                      date: "18/03/2022",
                      reminder: true,
                      tag: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            width: 75,
            height: 75,
            child: _menuPopup(),
          ),
        )
      ],
    );
  }
}
