import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/screens/core/reminder/edit_reminder.dart';
import 'package:noty_client/screens/core/reminder/new_reminder.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/content_text.dart';
import 'package:noty_client/widgets/typography/header_text.dart';
import 'package:provider/provider.dart';

class ReminderFragment extends StatefulWidget {
  const ReminderFragment({Key? key}) : super(key: key);

  @override
  State<ReminderFragment> createState() => _ReminderFragmentState();
}

class _ReminderFragmentState extends State<ReminderFragment> {
  @override
  void initState() {
    super.initState();
    context.read<ReminderProvider>().readReminderJson().then((_) {
      context.read<ReminderProvider>().setLocalReminder();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: context.watch<ReminderProvider>().independentReminder.isNotEmpty ||
              context.watch<ReminderProvider>().noteReminders.isNotEmpty
          ? SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const HeaderText(
                        text: "All Reminders", size: Size.medium),
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      children: context
                          .watch<ReminderProvider>()
                          .independentReminder
                          .map(
                            (reminder) => GestureDetector(
                              onTap: () => showBarModalBottomSheet(
                                context: context,
                                builder: (context) => EditReminder(
                                  title: reminder.title,
                                  details: reminder.description,
                                  date: reminder.remindDate,
                                  reminderId: reminder.reminderId,
                                  prevScreen: "Reminder",
                                  noteId: "",
                                  reminderState: reminder.success,
                                ),
                                expand: true,
                              ),
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 1.2,
                                          child: Checkbox(
                                            checkColor: Colors.black,
                                            value: reminder.success,
                                            shape: const CircleBorder(),
                                            onChanged: (bool? value) {
                                              setState(() {
                                                reminder.success = value!;
                                              });
                                              context
                                                  .read<ReminderProvider>()
                                                  .updateReminderProgress(
                                                      reminder.reminderId,
                                                      reminder.success,
                                                      context);
                                            },
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: DateFormat(
                                                          "dd-MM-yyyy HH:mm")
                                                      .format(DateTime.parse(
                                                          reminder.remindDate))
                                                      .toString() !=
                                                  "01-01-0001 00:00"
                                              ? MainAxisAlignment.center
                                              : MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: screenWidth / 1.8,
                                              child: Text(
                                                reminder.title,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            DateFormat("dd-MM-yyyy HH:mm")
                                                        .format(DateTime.parse(
                                                            reminder
                                                                .remindDate))
                                                        .toString() !=
                                                    "01-01-0001 00:00"
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: ContentText(
                                                        text: DateFormat(
                                                                "dd-MM-yyyy HH:mm")
                                                            .format(DateTime
                                                                .parse(reminder
                                                                    .remindDate))
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
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Column(
                    children: context
                        .watch<ReminderProvider>()
                        .noteReminders
                        .map(
                          (noteReminder) => CurvedCard(
                            child: GestureDetector(
                              onTap: (() {
                                context
                                    .read<NotesProvider>()
                                    .readNoteDetailJson(noteReminder.noteId)
                                    .then(
                                      (_) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NoteDetailScreen(
                                                  previousScreen: "Reminders",
                                                  noteId: noteReminder.noteId,
                                                  noteTitle:
                                                      noteReminder.title),
                                        ),
                                      ),
                                    );
                              }),
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(8, 15, 8, 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 4),
                                          child: ContentText(
                                              text: noteReminder.title,
                                              size: Size.large),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 4, bottom: 4),
                                          child: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Color(0xff434345),
                                      indent: 10,
                                      endIndent: 5,
                                    ),
                                    Column(
                                      children: noteReminder.reminders
                                          .map(
                                            (reminder) => Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 2),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Transform.scale(
                                                        scale: 1.2,
                                                        child: Checkbox(
                                                          checkColor:
                                                              Colors.black,
                                                          value:
                                                              reminder.success,
                                                          shape:
                                                              const CircleBorder(),
                                                          onChanged:
                                                              (bool? value) {
                                                            setState(() {
                                                              reminder.success =
                                                                  value!;
                                                            });
                                                            context
                                                                .read<
                                                                    ReminderProvider>()
                                                                .updateReminderProgress(
                                                                    reminder.id,
                                                                    reminder
                                                                        .success,
                                                                    context);
                                                          },
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(reminder.title),
                                                          DateFormat("dd-MM-yyyy HH:mm")
                                                                      .format(DateTime.parse(
                                                                          reminder
                                                                              .remindDate))
                                                                      .toString() !=
                                                                  "01-01-0001 00:00"
                                                              ? Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 4),
                                                                  child: ContentText(
                                                                      text: DateFormat(
                                                                              "dd-MM-yyyy HH:mm")
                                                                          .format(DateTime.parse(reminder
                                                                              .remindDate))
                                                                          .toString(),
                                                                      size: Size
                                                                          .tiny),
                                                                )
                                                              : Container(),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            margin: 20,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text("No reminders"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBarModalBottomSheet(
          context: context,
          builder: (context) => const NewReminder(
            prevScreen: "Reminder",
            noteId: "",
          ),
          expand: true,
        ),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
