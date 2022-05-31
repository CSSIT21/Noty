import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/models/response/reminder/reminder_in_note.dart';
import 'package:noty_client/screens/core/note/action_button.dart';
import 'package:noty_client/screens/core/note/checkbox.dart';
import 'package:noty_client/screens/core/reminder/edit_reminder.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/loading_animation.dart';
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

class _NoteDetailScreenState extends State<NoteDetailScreen>
    with TickerProviderStateMixin {
  List<Widget> details = [];

  Future<Widget> getReminderList(int i) async {
    if (Provider.of<NotesProvider>(context, listen: false)
            .noteDetails
            .details[i]
            .type ==
        "reminder") {
      var response = await context
          .read<ReminderProvider>()
          .getReminderInNoteTitle(
              Provider.of<NotesProvider>(context, listen: false)
                  .noteDetails
                  .details[i]
                  .data!
                  .content,
              context);
      if (response is ReminderInNote) {
        return GestureDetector(
          onTap: () => showBarModalBottomSheet(
            context: context,
            builder: (context) => EditReminder(
              title: response.reminder.title,
              details: response.reminder.description,
              date: response.reminder.remindDate,
              reminderId: response.reminder.reminderId,
              prevScreen: "Note",
              noteId: widget.noteId,
              updateNote: reminderHandler,
              reminderState: response.reminder.success,
            ),
            expand: true,
          ),
          behavior: HitTestBehavior.translucent,
          child: Container(
            margin: const EdgeInsets.only(top: 4, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.2,
                      child: CheckBox(
                        isChecked: response.reminder.success,
                        reminderId: response.reminder.reminderId,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(response.reminder.title),
                        DateFormat("dd-MM-yyyy HH:mm")
                                    .format(DateTime.parse(
                                        response.reminder.remindDate))
                                    .toString() !=
                                "01-01-0001 00:00"
                            ? Container(
                                padding: const EdgeInsets.only(top: 4),
                                child: ContentText(
                                    text: DateFormat("dd-MM-yyyy HH:mm")
                                        .format(DateTime.parse(
                                            response.reminder.remindDate))
                                        .toString(),
                                    size: Size.tiny),
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.only(right: 12),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } else if (Provider.of<NotesProvider>(context, listen: false)
                .noteDetails
                .details[i]
                .type ==
            "text" ||
        Provider.of<NotesProvider>(context, listen: false)
                .noteDetails
                .details[i]
                .type ==
            "h1" ||
        Provider.of<NotesProvider>(context, listen: false)
                .noteDetails
                .details[i]
                .type ==
            "h2") {
      return TextFormField(
        initialValue: Provider.of<NotesProvider>(context, listen: false)
            .noteDetails
            .details[i]
            .data!
            .content,
        keyboardType: TextInputType.multiline,
        keyboardAppearance: Brightness.dark,
        maxLines: null,
        style: TextStyle(
          fontSize: Provider.of<NotesProvider>(context, listen: false)
                      .noteDetails
                      .details[i]
                      .type ==
                  "h1"
              ? 24
              : Provider.of<NotesProvider>(context, listen: false)
                          .noteDetails
                          .details[i]
                          .type ==
                      "h2"
                  ? 20
                  : 16,
          fontWeight: Provider.of<NotesProvider>(context, listen: false)
                      .noteDetails
                      .details[i]
                      .type ==
                  "h1"
              ? FontWeight.w500
              : Provider.of<NotesProvider>(context, listen: false)
                          .noteDetails
                          .details[i]
                          .type ==
                      "h2"
                  ? FontWeight.w500
                  : FontWeight.normal,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
          border: InputBorder.none,
          hintText: Provider.of<NotesProvider>(context, listen: false)
                      .noteDetails
                      .details[i]
                      .type ==
                  "h1"
              ? "Heading 1"
              : Provider.of<NotesProvider>(context, listen: false)
                          .noteDetails
                          .details[i]
                          .type ==
                      "h2"
                  ? "Heading 2"
                  : "Text",
          hintStyle: TextStyle(
            color: const Color(0xff636367),
            fontSize: Provider.of<NotesProvider>(context, listen: false)
                        .noteDetails
                        .details[i]
                        .type ==
                    "h1"
                ? 24
                : Provider.of<NotesProvider>(context, listen: false)
                            .noteDetails
                            .details[i]
                            .type ==
                        "h2"
                    ? 20
                    : 16,
            fontWeight: Provider.of<NotesProvider>(context, listen: false)
                        .noteDetails
                        .details[i]
                        .type ==
                    "h1"
                ? FontWeight.w500
                : Provider.of<NotesProvider>(context, listen: false)
                            .noteDetails
                            .details[i]
                            .type ==
                        "h2"
                    ? FontWeight.w500
                    : FontWeight.normal,
          ),
        ),
        onChanged: (text) =>
            context.read<NotesProvider>().editNoteText(i, text),
        onTap: () {
          context.read<NotesProvider>().setCurrentTfIndex(i);
        },
      );
    }
    return Container();
  }

  void reminderHandler() {
    List<Future<Widget>> future = [];
    for (var i = 0;
        i <
            Provider.of<NotesProvider>(context, listen: false)
                .noteDetails
                .details
                .length;
        i++) {
      future.add(getReminderList(i));
    }
    Future.wait(future).then((value) {
      setState(() {
        details = value;
      });
    });
  }

  saveNote(BuildContext context) {
    context.read<NotesProvider>().editNote(context).then((_) {
      updateFolderList(context);
      context.read<NotesProvider>().readJsonData();
      context.read<ReminderProvider>().readReminderJson();
    });
  }

  saveNoteAndBack(BuildContext context) {
    showLoading(context);
    context.read<NotesProvider>().editNote(context).then((_) {
      Future.wait([
        updateFolderList(context),
        context.read<NotesProvider>().readJsonData(),
        context.read<ReminderProvider>().readReminderJson()
      ]).then((_) {
        Navigator.pop(context);
        Navigator.pop(context);
        context.read<NotesProvider>().clearNoteDetail();
        setState(() {
          details = [];
        });
      });
    });
  }

  Future<void> updateFolderList(BuildContext context) async {
    if (widget.folderId != null) {
      await context
          .read<NotesProvider>()
          .readFolderNoteListJson(widget.folderId ?? "");
    }
  }

  @override
  void initState() {
    context.read<NotesProvider>().readNoteDetailJson(widget.noteId);
    context.read<ReminderProvider>().readReminderJson();
    reminderHandler();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    void addNoteDetail(String noteId, String type) {
      context.read<NotesProvider>().addNoteDetail(noteId, type);
      reminderHandler();
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        saveNote(context);
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 120,
            child: AppBarText(
                text: context.watch<NotesProvider>().noteDetails.title),
          ),
          centerTitle: true,
          leadingWidth: 100,
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: ThemeConstant.colorPrimaryLight,
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(
                      widget.previousScreen,
                      style: TextStyle(
                          fontSize: 17, color: ThemeConstant.colorPrimaryLight),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              saveNoteAndBack(context);
            },
          ),
          actions: [
            MediaQuery.of(context).viewInsets.bottom > 0 &&
                    context.read<NotesProvider>().currentTextFieldIndex != -1
                ? TextButton(
                    onPressed: () {
                      context.read<NotesProvider>().deleteNoteDetail(
                          context.read<NotesProvider>().currentTextFieldIndex);
                      reminderHandler();
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
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
                      keyboardAppearance: Brightness.dark,
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
                        Provider.of<NotesProvider>(context, listen: false)
                            .noteDetails
                            .title = text;
                      }),
                      onTap: () {
                        context.read<NotesProvider>().setCurrentTfIndex(-1);
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 10),
                      child: const Divider(
                        color: Color(0xff434345),
                        height: 1,
                      ),
                    ),
                    Column(
                      children: details,
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
                        addNoteDetail: addNoteDetail,
                        detailsHandler: reminderHandler,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
