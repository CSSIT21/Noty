import 'package:flutter/material.dart';
import 'package:noty_client/widgets/list/FolderListItem.dart';
import 'package:noty_client/widgets/typography/TitleText.dart';

class NotesFragment extends StatefulWidget {
  const NotesFragment({Key? key}) : super(key: key);

  @override
  State<NotesFragment> createState() => _NotesFragmentState();
}

class _NotesFragmentState extends State<NotesFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TitleText(text: "Folders"),
        FolderListItem(name: "Learning", count: 10),
        FolderListItem(name: "Diary", count: 7),
        TitleText(text: "All notes")
      ],
    );
  }
}
