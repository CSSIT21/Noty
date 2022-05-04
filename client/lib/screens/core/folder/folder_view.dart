import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/models/response/notes/folder_data.dart';
import 'package:noty_client/screens/core/folder/dialog_edit_folder.dart';
import 'package:noty_client/screens/core/note/new_note_screen.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class FolderDetailScreen extends StatefulWidget {
  final String folderId;
  const FolderDetailScreen({Key? key, required this.folderId})
      : super(key: key);

  @override
  State<FolderDetailScreen> createState() => _FolderDetailScreenState();
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    FolderData folder = context
        .watch<NotesProvider>()
        .folders
        .singleWhere((folder) => folder.folderId == widget.folderId);
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 120,
          child: AppBarText(text: folder.name),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: const LeadingButton(
          text: "Folders",
        ),
        actions: [
          TextButton(
            onPressed: () =>
                showEditFolderDialog(context, folder.name, folder.folderId),
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
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
          child: context.watch<NotesProvider>().folderNoteList.isEmpty
              ? const Center(child: Text("No notes"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const HeaderText(
                          text: "All Notes", size: Size.medium),
                      margin: const EdgeInsets.only(bottom: 20),
                    ),
                    CurvedCard(
                      margin: 25,
                      child: Column(
                        children: dividerInsert(
                          context
                              .watch<NotesProvider>()
                              .folderNoteList
                              .mapIndexed(
                                (index, note) => NoteListItem(
                                  title: note.title,
                                  date: note.updatedAt,
                                  noteId: note.noteId,
                                  previousScreen: folder.name,
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewNoteScreen(
                noteName: "Untitled Note",
                previousScreen: folder.name,
              ), //     ),
            ),
          );
        },
        child: const Icon(CupertinoIcons.pencil_outline),
      ),
    );
  }
}
