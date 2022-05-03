import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';
import 'package:noty_client/screens/core/folder/folder_move_dialog.dart';
import 'package:noty_client/services/notes_sevice.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class NoteSection extends StatefulWidget {
  const NoteSection({Key? key}) : super(key: key);

  @override
  State<NoteSection> createState() => _NoteSectionState();
}

class _NoteSectionState extends State<NoteSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              context
                  .watch<NotesProvider>()
                  .notes
                  .mapIndexed(
                    (index, note) => Slidable(
                      key: ValueKey(index),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              var folderId =
                                  await NoteService.getNoteDetail(note.noteId);
                              if (folderId is NoteDetailResponse) {
                                showBarModalBottomSheet(
                                  context: context,
                                  builder: (context) => FolderMoveDialog(
                                      folderId: folderId.data.folderId),
                                  expand: true,
                                );
                              }
                            },
                            backgroundColor: ThemeConstant.colorPrimaryLight,
                            foregroundColor: Colors.white,
                            icon: CupertinoIcons.folder_fill,
                          ),
                          SlidableAction(
                            onPressed: (BuildContext context) {},
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
                        previousScreen: "All Notes",
                      ),
                    ),
                  )
                  .toList(),
              const Divider(
                color: Color(0xff434345),
                indent: 20,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
