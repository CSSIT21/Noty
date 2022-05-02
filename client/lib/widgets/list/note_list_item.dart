import 'package:flutter/material.dart';
import 'package:noty_client/models/note_detail.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/reminder/reminder_label.dart';
import 'package:noty_client/widgets/tag/tag_label.dart';
import 'package:provider/provider.dart';

class NoteListItem extends StatefulWidget {
  final String title;
  final String date;
  final int noteIndex;

  const NoteListItem({
    Key? key,
    required this.title,
    required this.date,
    required this.noteIndex,
  }) : super(key: key);

  @override
  State<NoteListItem> createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
  var tag = false;
  var reminder = false;

  @override
  Widget build(BuildContext context) {
    List<NoteDetail> noteDetails =
        context.watch<NotesProvider>().notes[widget.noteIndex].noteDetail;
    double screenWidth = MediaQuery.of(context).size.width;

    for (var i = 0; i < noteDetails.length; i++) {
      if (noteDetails[i].tags!.isNotEmpty) {
        tag = true;
      }
      break;
    }
    for (var i = 0; i < noteDetails.length; i++) {
      if (noteDetails[i].type == 'reminder') {
        reminder = true;
      }
    }

    return Container(
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
                    widget.date,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ),
                Row(
                  children: [
                    reminder
                        ? Container(
                            child: const ReminderLabel(),
                            margin: const EdgeInsets.only(right: 6),
                          )
                        : Container(),
                    tag
                        ? const TagLabel(
                            textColor: Color(0xff828282),
                            bgColor: Color(0xff252525),
                            title: "Tag",
                            iconFilled: true,
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
    );
  }
}
