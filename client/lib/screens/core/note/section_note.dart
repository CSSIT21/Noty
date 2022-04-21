import 'package:flutter/material.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class NoteSection extends StatelessWidget {
  const NoteSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: const HeaderText(text: "Notes", size: Size.medium),
          margin: const EdgeInsets.only(bottom: 20),
        ),
        CurvedCard(
          child: Column(
            children: dividerInsert(
                const [
                  NoteListItem(
                    name: "IEEE Spectrum",
                    date: "18/03/2022",
                    reminder: true,
                    tag: true,
                  ),
                  NoteListItem(
                    name: "12345678901234567890123456aaasss",
                    date: "18/03/2022",
                    reminder: false,
                    tag: true,
                  ),
                  NoteListItem(
                    name: "Just a simple note",
                    date: "18/03/2022",
                    reminder: true,
                    tag: false,
                  ),
                  NoteListItem(
                    name: "Hate Flutter",
                    date: "18/03/2022",
                    reminder: false,
                    tag: false,
                  ),
                  NoteListItem(
                    name: "Hate Flutter",
                    date: "18/03/2022",
                    reminder: true,
                    tag: false,
                  ),
                ],
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
