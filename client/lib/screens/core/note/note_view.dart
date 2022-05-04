import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';
import 'package:noty_client/models/response/notes/note_detail_details.dart';
import 'package:noty_client/screens/core/note/action_button.dart';
import 'package:noty_client/screens/core/reminder/edit_reminder.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/leading_button.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:noty_client/widgets/typography/content_text.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final String previousScreen;
  final String noteId;
  final String noteTitle;
  final String? folderId;

  const NoteDetailScreen({
    Key? key,
    required this.previousScreen,
    required this.noteId,
    required this.noteTitle,
    this.folderId,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    context.read<NotesProvider>().readNoteDetailJson(widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    NoteDetailData noteDetail = context.watch<NotesProvider>().noteDetails;
    List<NoteDetailDataDetails> noteDetails =
        context.watch<NotesProvider>().noteDetails.details;

    // void addNoteDetail(int noteIndex, String type) {
    //   // context.read<NotesProvider>().addNoteDetail(noteIndex, type);
    //   setState(() {});
    // }

    // void deleteNoteDetail(int noteDetailIndex) {
    //   context
    //       .read<NotesProvider>()
    //       .deleteNoteDetail(widget.noteIndex, noteDetailIndex);
    //   setState(() {});
    // }
    void handleBack() {
      if (widget.folderId != null) {
        context
            .read<NotesProvider>()
            .readFolderNoteListJson(widget.folderId ?? "");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 120,
          child: AppBarText(
              text: context.watch<NotesProvider>().noteDetails.title),
        ),
        centerTitle: true,
        leadingWidth: 100,
        leading: LeadingButton(
          text: widget.previousScreen,
          onPressed: handleBack,
        ),
        actions: [
          MediaQuery.of(context).viewInsets.bottom > 0
              ? TextButton(
                  onPressed: () {
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.noteTitle,
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
                      noteDetail.title = text;
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
                          child: noteDetails[i].type != "reminder"
                              ? TextFormField(
                                  initialValue: noteDetails[i].data!.content,
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
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 4),
                                    border: InputBorder.none,
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
                                    suffix: currentFocus.hasFocus &&
                                            noteDetails[i].data!.content == ""
                                        ? IconButton(
                                            onPressed: () {},
                                            // deleteNoteDetail(i),
                                            icon: const Icon(
                                              Icons.clear,
                                              size: 20,
                                            ),
                                            padding: const EdgeInsets.all(0),
                                            splashColor: Colors.transparent,
                                          )
                                        : null,
                                  ),
                                  onChanged: (text) => setState(() {
                                    noteDetails[i].data!.content = text;
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
                                    margin: const EdgeInsets.only(
                                        top: 4, bottom: 4),
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
                      noteId: widget.noteId,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
