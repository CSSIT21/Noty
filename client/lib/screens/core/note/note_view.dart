import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/models/note_detail.dart';
import 'package:noty_client/screens/core/note/action_button.dart';
import 'package:noty_client/screens/core/reminder/edit_reminder.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:noty_client/widgets/typography/content_text.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final String noteName;
  final String previousScreen;
  final int noteIndex;

  const NoteDetailScreen({
    Key? key,
    required this.noteName,
    required this.previousScreen,
    required this.noteIndex,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  bool isChecked = false;
  String noteTitle = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NoteDetail> noteDetails =
        context.watch<NotesProvider>().notes[widget.noteIndex].noteDetail;

    void addNoteDetail(int noteIndex, String type) {
      context.read<NotesProvider>().addNoteDetail(noteIndex, type);
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 120,
          child: AppBarText(text: widget.noteName),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: LeadingButton(
          text: widget.previousScreen,
        ),
        actions: [
          MediaQuery.of(context).viewInsets.bottom > 0
              ? TextButton(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TextFormField(
                    initialValue:
                        widget.noteName.isNotEmpty ? widget.noteName : null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration.collapsed(
                      hintText: "Note Title",
                      hintStyle: TextStyle(
                        color: Color(0xff636367),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onChanged: (text) => setState(() {
                      noteTitle = text;
                    }),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 10),
                    child: const Divider(
                      color: Color(0xff434345),
                      height: 1,
                    ),
                  ),
                  Column(
                    children: [
                      for (var i = 0; i < noteDetails.length; i++)
                        Container(
                          margin: const EdgeInsets.only(bottom: 6, top: 6),
                          child: noteDetails[i].type != "reminder"
                              ? TextFormField(
                                  initialValue: noteDetails[i].detail,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  style: TextStyle(
                                    fontSize: noteDetails[i].type == "h1"
                                        ? 24
                                        : noteDetails[i].type == "h2"
                                            ? 20
                                            : 16,
                                    fontWeight: noteDetails[i].type == "h1"
                                        ? FontWeight.w500
                                        : noteDetails[i].type == "h2"
                                            ? FontWeight.w500
                                            : FontWeight.normal,
                                  ),
                                  decoration: InputDecoration.collapsed(
                                    hintText: noteDetails[i].type == "h1"
                                        ? "Heading 1"
                                        : noteDetails[i].type == "h2"
                                            ? "Heading 2"
                                            : "Text",
                                    hintStyle: TextStyle(
                                      color: const Color(0xff636367),
                                      fontSize: noteDetails[i].type == "h1"
                                          ? 24
                                          : noteDetails[i].type == "h2"
                                              ? 20
                                              : 16,
                                      fontWeight: noteDetails[i].type == "h1"
                                          ? FontWeight.w500
                                          : noteDetails[i].type == "h2"
                                              ? FontWeight.w500
                                              : FontWeight.normal,
                                    ),
                                  ),
                                  onChanged: (text) => setState(() {
                                    noteDetails[i].detail = text;
                                  }),
                                )
                              : GestureDetector(
                                  onTap: () => showBarModalBottomSheet(
                                    context: context,
                                    builder: (context) => const EditReminder(),
                                    expand: true,
                                  ),
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Transform.scale(
                                              scale: 1.2,
                                              child: Checkbox(
                                                checkColor: Colors.black,
                                                value: isChecked,
                                                shape: const CircleBorder(),
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value!;
                                                  });
                                                },
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 4),
                                                  child: const Text(
                                                      "Summarize the topic"),
                                                ),
                                                const ContentText(
                                                    text: "Monday, 20:00",
                                                    size: Size.tiny),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30, right: 15),
              width: 75,
              height: 75,
              child: MediaQuery.of(context).viewInsets.bottom > 0
                  ? null
                  : NewNoteAction(
                      noteIndex: widget.noteIndex,
                      addNoteDetail: addNoteDetail,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
