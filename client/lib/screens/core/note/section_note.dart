import 'package:flutter/material.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:collection/collection.dart';

class NoteSection extends StatelessWidget {
  final List<Notes> notes;
  const NoteSection({Key? key, required this.notes}) : super(key: key);

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
                notes
                    .mapIndexed(
                      (index, note) => GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FolderDetailScreen(),//     ),
                          //   ),
                          // );
                        },
                        behavior: HitTestBehavior.translucent,
                        child: Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
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
