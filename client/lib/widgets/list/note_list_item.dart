import 'package:flutter/material.dart';
import 'package:noty_client/models/response/notes/note_data.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/reminder/reminder_label.dart';
import 'package:noty_client/widgets/tag/tag_label.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class NoteListItem extends StatefulWidget {
  final String title;
  final String date;
  final String noteId;
  final String previousScreen;
  final String? folderId;

  const NoteListItem({
    Key? key,
    required this.title,
    required this.date,
    required this.noteId,
    required this.previousScreen,
    this.folderId,
  }) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().readJsonData();
  }

  @override
  Widget build(BuildContext context) {
    NoteData note = Provider.of<NotesProvider>(context, listen: false)
        .notes
        .firstWhere((note) => note.noteId == widget.noteId);
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        context.read<NotesProvider>().readNoteDetailJson(widget.noteId).then(
              (_) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteDetailScreen(
                    previousScreen: widget.previousScreen,
                    noteId: widget.noteId,
                    noteTitle: widget.title,
                    folderId: widget.folderId,
                  ), //     ),
                ),
              ),
            );
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth / 1.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      widget.title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      DateFormat.yMd().format(DateTime.parse(widget.date)),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Row(
                    children: [
                      note.hasReminder
                          ? Container(
                              child: const ReminderLabel(),
                              margin: const EdgeInsets.only(right: 6),
                            )
                          : Container(),
                      note.tags.isNotEmpty
                          ? const TagLabel(
                              title: "Tag",
                              iconFilled: true,
                              isSelected: false,
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
