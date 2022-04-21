import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/screens/core/note/popup_menu.dart';
import 'package:noty_client/screens/core/note/section_folder.dart';
import 'package:noty_client/screens/core/note/section_note.dart';

class NotesFragment extends StatefulWidget {
  const NotesFragment({Key? key}) : super(key: key);

  @override
  State<NotesFragment> createState() => _NotesFragmentState();
}

class _NotesFragmentState extends State<NotesFragment> {
  List<Folder> _folders = [];

  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/folders.json');
    final List<dynamic> datas = await json.decode(response);
    List<Folder> temp = datas.map((data) {
      return Folder(id: data["id"], name: data["name"], count: data["count"]);
    }).toList();
    if (mounted) {
      setState(() => _folders = temp);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _readJson();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [FolderSection(folders: _folders), const NoteSection()],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SizedBox(
            width: 75,
            height: 75,
            child: WidgetsBinding.instance!.window.viewInsets.bottom > 0
                ? null
                : menuPopup(context),
          ),
        )
      ],
    );
  }
}
