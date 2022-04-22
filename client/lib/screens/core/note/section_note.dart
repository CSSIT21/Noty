import 'package:flutter/material.dart';
import 'package:noty_client/models/notes.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

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
          child: Column(
            children: dividerInsert(
                notes
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
                )),
          ),
        ),
      ],
    );
  }
}
