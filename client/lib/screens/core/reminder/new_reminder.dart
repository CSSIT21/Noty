import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:provider/provider.dart';

class NewReminder extends StatefulWidget {
  final String prevScreen;
  final String noteId;
  final Function? updateNote;
  const NewReminder(
      {Key? key,
      required this.prevScreen,
      required this.noteId,
      this.updateNote})
      : super(key: key);

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  final _titleController = TextEditingController(text: "");
  final _detailsController = TextEditingController(text: "");
  DateTime selectedDate = DateTime.parse("0001-01-01T00:00:00Z");
  bool isDateSelected = false;

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (value) {
                setState(() {
                  selectedDate = value;
                  isDateSelected = true;
                });
              },
              use24hFormat: true,
              initialDateTime: DateTime.now(),
              minimumYear: DateTime.now().year,
              maximumYear: 2099,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        appBar: AppBar(
          title: const AppBarText(text: 'New Reminder'),
          centerTitle: true,
          leadingWidth: 100,
          toolbarHeight: 60,
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text(
                    "Cancel",
                    style: TextStyle(
                        fontSize: 17, color: ThemeConstant.colorPrimaryLight),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_titleController.text.isNotEmpty) {
                  var response = await context
                      .read<ReminderProvider>()
                      .addReminder(
                          _titleController.text,
                          _detailsController.text,
                          selectedDate.toIso8601String(),
                          context);
                  if (response != false && widget.prevScreen == "Note") {
                    context
                        .read<NotesProvider>()
                        .addNoteDetailReminder(widget.noteId, response);
                    context.read<NotesProvider>().editNote(context);
                    context.read<ReminderProvider>().readReminderJson();
                    widget.updateNote!();
                    context
                        .read<NotesProvider>()
                        .readNoteDetailJson(widget.noteId)
                        .then(
                          (_) => Navigator.pop(context),
                        );
                  } else {
                    Navigator.pop(context);
                  }
                } else {
                  var error = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    content: const Text("Title cannot be empty"),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(error);
                }
              },
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                "Add",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: ThemeConstant.colorPrimaryLight),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          controller: ModalScrollController.of(context),
          child: Container(
            color: ThemeConstant.colorPrimaryDark,
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: ThemeConstant.textFieldBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 18, 12, 18),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              child: TextField(
                                controller: _titleController,
                                keyboardAppearance: Brightness.dark,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Title',
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                ),
                              ),
                            ),
                            const Divider(
                              color: Color(0xff434345),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              child: TextField(
                                controller: _detailsController,
                                keyboardAppearance: Brightness.dark,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                maxLines: 4,
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Details',
                                  hintStyle: TextStyle(
                                      color: ThemeConstant.textFieldTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: showDatePicker,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.only(left: 12, right: 14),
                    height: 50,
                    decoration: BoxDecoration(
                      color: ThemeConstant.textFieldBgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              child: const Icon(
                                CupertinoIcons.calendar,
                              ),
                            ),
                            const Text("Date & Time"),
                          ],
                        ),
                        isDateSelected
                            ? Text(
                                DateFormat("dd-MM-yyyy HH:mm")
                                    .format(selectedDate),
                                style: TextStyle(
                                    color: ThemeConstant.colorPrimaryLight),
                              )
                            : const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
