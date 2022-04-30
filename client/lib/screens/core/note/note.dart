import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/models/folder.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/note/popup_menu.dart';
import 'package:noty_client/screens/core/note/section_folder.dart';
import 'package:noty_client/screens/core/note/section_note.dart';

class NotesFragment extends StatefulWidget {
  final List<Folder> folders;
  final List<Notes> notes;
  const NotesFragment({Key? key, required this.folders, required this.notes})
      : super(key: key);

  @override
  State<NotesFragment> createState() => _NotesFragmentState();
}

class _NotesFragmentState extends State<NotesFragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FolderSection(folders: widget.folders, notes: widget.notes),
                NoteSection(notes: widget.notes),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
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
