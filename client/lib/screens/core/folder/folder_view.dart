import 'package:flutter/material.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/notes.dart';
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

_showPopupMenu(context, screenHeight) {
  showMenu(
    context: context,
    color: const Color(0xff232323),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    position: RelativeRect.fromLTRB(100, screenHeight - 180, 0, 0),
    items: [
      PopupMenuItem(
        value: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New Note",
              style: TextStyle(
                color: ThemeConstant.textColorPrimary,
                fontSize: 16,
              ),
            ),
            Icon(
              Icons.edit_note_rounded,
              color: ThemeConstant.colorPrimaryLight,
              size: 24,
            )
          ],
        ),
      ),
    ],
  );
}

class _FolderDetailScreenState extends State<FolderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

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
        onPressed: () {
          _showPopupMenu(context, screenHeight);
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
