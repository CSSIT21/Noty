import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/utils/widget/divider_insert.dart';
import 'package:noty_client/widgets/list/note_list_item.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/tag/tag_label.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class TagFragment extends StatefulWidget {
  const TagFragment({Key? key}) : super(key: key);

  @override
  State<TagFragment> createState() => _TagFragmentState();
}

class _TagFragmentState extends State<TagFragment> {
  Color tagBgColor = const Color(0xff252525);
  Color tagTextColor = const Color(0xff828282);
  // void addNoteDetail(int noteIndex, String type) {
  //   context.read<NotesProvider>().addNoteDetail(noteIndex, type);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i = 0; i < 8; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          tagBgColor = tagBgColor == const Color(0xff252525)
                              ? ThemeConstant.colorPrimaryLight
                              : const Color(0xff252525);
                          tagTextColor = tagTextColor == const Color(0xff828282)
                              ? ThemeConstant.textColorPrimary
                              : const Color(0xff828282);
                        });
                      },
                      child: TagLabel(
                        bgColor: tagBgColor,
                        textColor: tagTextColor,
                        title: "3D-Printer",
                        iconFilled: false,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: const HeaderText(text: "All Tags", size: Size.medium),
          ),
          CurvedCard(
            child: Container(
              padding: const EdgeInsets.only(bottom: 5, top: 5),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text("# 3D-Printer"),
                  ),
                  Column(
                    children: dividerInsert(
                      context
                          .watch<NotesProvider>()
                          .notes
                          .mapIndexed(
                            (index, note) => NoteListItem(
                              title: note.title,
                              date: note.updatedAt,
                              noteId: note.noteId,
                              previousScreen: "Tags",
                            ),
                          )
                          .toList(),
                      const Divider(
                        color: Color(0xff434345),
                        indent: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            margin: 20,
          ),
        ],
      ),
    );
  }
}
