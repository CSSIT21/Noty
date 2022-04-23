import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/note_detail.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/note/popup_menu.dart';
import 'package:noty_client/screens/core/note/section_folder.dart';
import 'package:noty_client/screens/core/note/section_note.dart';
import 'package:http/http.dart' as http;

class NotesFragment extends StatefulWidget {
  const NotesFragment({Key? key}) : super(key: key);

  @override
  State<NotesFragment> createState() => _NotesFragmentState();
}

class _NotesFragmentState extends State<NotesFragment> {
  List<Folder> _folders = [];
  List<Notes> _notes = [];

  Future<void> _readJson() async {
    final response = await http.get(
        Uri.parse('https://mock-noty.mixkoap.com/test-payload.json'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8',
        });
    final Map<String, dynamic> datas = await json.decode(response.body);

    List<dynamic> foldersData = datas["folders"];
    List<dynamic> notesData = datas["notes"];

    List<Folder> tempFolders = foldersData.map((folder) {
      return Folder(
          folderId: folder["folder_id"],
          title: folder["title"],
          count: folder["count"]);
    }).toList();

    List<Notes> tempNotes = notesData.map((note) {
      List<dynamic> tempNoteDetail = note["note_detail"];
      List<NoteDetail> noteDetails = tempNoteDetail.map((noteDetail) {
        List<dynamic> tempTags = noteDetail["tags"] ?? [];
        List<String> tags = tempTags.map((tag) => tag.toString()).toList();
        return NoteDetail(
            type: noteDetail["type"],
            detail: noteDetail["detail"] ?? "",
            createdAt: noteDetail["created_at"] ?? "",
            reminderId: noteDetail["reminder_id"] ?? "",
            tags: tags);
      }).toList();
      return Notes(
        id: note["id"],
        userId: note["user_id"],
        title: note["title"],
        folderId: note["folder_id"],
        createdAt: note["created_at"],
        noteDetail: noteDetails,
      );
    }).toList();

    if (mounted) {
      setState(() {
        _folders = tempFolders;
        _notes = tempNotes;
      });
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
            children: [
              FolderSection(folders: _folders, notes: _notes),
              NoteSection(notes: _notes),
            ],
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
