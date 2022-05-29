import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/notes/folder_data.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';
import 'package:noty_client/screens/core/folder/dialog_edit_folder.dart';
import 'package:noty_client/screens/core/folder/folder_move_dialog.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/services/notes_sevice.dart';
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
  void initState() {
    super.initState();
    context.read<NotesProvider>().readFolderNoteListJson(widget.folderId);
  }

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
                                (index, note) => Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (BuildContext cont) async {
                                          var value =
                                              await NoteService.getNoteDetail(
                                                  note.noteId);
                                          if (value is NoteDetailResponse) {
                                            showBarModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  FolderMoveDialog(
                                                folderId: value.data.folderId,
                                                noteId: value.data.id,
                                              ),
                                              expand: true,
                                            );
                                          }
                                        },
                                        backgroundColor:
                                            ThemeConstant.colorPrimaryLight,
                                        foregroundColor: Colors.white,
                                        icon: CupertinoIcons.folder_fill,
                                      ),
                                      SlidableAction(
                                        onPressed: (BuildContext cont) {
                                          context
                                              .read<NotesProvider>()
                                              .deleteNote(note.noteId, context)
                                              .then((_) {
                                            context
                                                .read<NotesProvider>()
                                                .readFolderNoteListJson(
                                                    folder.folderId);
                                            context
                                                .read<NotesProvider>()
                                                .readJsonData();
                                          });
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_rounded,
                                      ),
                                    ],
                                  ),
                                  child: NoteListItem(
                                    title: note.title,
                                    date: note.updatedAt,
                                    noteId: note.noteId,
                                    previousScreen: folder.name,
                                    folderId: widget.folderId,
                                  ),
                                ),
                              )
                              .toList(),
                          const Divider(
                            color: Color(0xff434345),
                            indent: 25,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context
              .read<NotesProvider>()
              .addNote(widget.folderId, context)
              .then((response) {
            if (response != false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(
                          previousScreen: folder.name,
                          noteId: response,
                          noteTitle: "Untitled",
                          folderId: widget.folderId,
                        ) //     ),
                    ),
              );
            }
          });
        },
        child: const Icon(CupertinoIcons.pencil_outline),
      ),
    );
  }
}
