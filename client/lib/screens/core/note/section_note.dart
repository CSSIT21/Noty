import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
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
                      (index, note) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteDetailScreen(
                                noteName: note.title,
                                previousScreen: "All Notes",
                                noteIndex: index,
                              ), //     ),
                            ),
                          );
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {},
                                backgroundColor:
                                    ThemeConstant.colorPrimaryLight,
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
                            date: note.createdAt,
                            noteDetails: note.noteDetail,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                const Divider(
                  color: Color(0xff434345),
                  indent: 20,
                  height: 1,
                )),
          ),
        ),
      ],
    );
  }
}
