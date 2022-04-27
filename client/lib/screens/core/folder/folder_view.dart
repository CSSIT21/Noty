import 'package:flutter/material.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/screens/core/folder/dialog_edit_folder.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class FolderDetailScreen extends StatefulWidget {
  final String folderName;
  final List<Notes> notes;
  const FolderDetailScreen(
      {Key? key, required this.folderName, required this.notes})
      : super(key: key);

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 120,
          child: AppBarText(text: widget.folderName),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: const LeadingButton(
          text: "Folders",
        ),
        actions: [
          TextButton(
            onPressed: () => showEditFolderDialog(context),
            child: const Text(
              "Edit",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const HeaderText(text: "All Notes", size: Size.medium),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              CurvedCard(
                margin: 25,
                child: Column(
                  children: dividerInsert(
                    widget.notes
                        .map(
                          (note) => NoteListItem(
                            title: note.title,
                            date: note.createdAt,
                            noteDetails: note.noteDetail,
                          ),
                        )
                        .toList(),
                    const Divider(
                      color: Color(0xff434345),
                      indent: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit_rounded),
      ),
    );
  }
}
