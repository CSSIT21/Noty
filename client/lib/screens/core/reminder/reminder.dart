import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/screens/core/note/note_view.dart';
import 'package:noty_client/screens/core/reminder/edit_reminder.dart';
import 'package:noty_client/screens/core/reminder/new_reminder.dart';
import 'package:noty_client/types/widget/placement.dart';
import 'package:noty_client/widgets/surface/curved_card.dart';
import 'package:noty_client/widgets/typography/content_text.dart';
import 'package:noty_client/widgets/typography/header_text.dart';

class ReminderFragment extends StatefulWidget {
  const ReminderFragment({Key? key}) : super(key: key);

  @override
  State<ReminderFragment> createState() => _ReminderFragmentState();
}

class _ReminderFragmentState extends State<ReminderFragment> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 20, right: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const HeaderText(text: "All Reminders", size: Size.medium),
              margin: const EdgeInsets.only(bottom: 20),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  for (var i = 0; i < 2; i++)
                    GestureDetector(
                      onTap: () => showBarModalBottomSheet(
                        context: context,
                        builder: (context) => const EditReminder(),
                        expand: true,
                      ),
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      child: const Text("Summarize the topic"),
                                    ),
                                    const ContentText(
                                        text: "Monday, 20:00", size: Size.tiny),
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
                ],
              ),
            ),
            CurvedCard(
              child: GestureDetector(
                onTap: (() {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const NoteDetailScreen(
                  //       previousScreen: "Reminders",
                  //       noteId: 0,
                  //     ), //     ),
                  //   ),
                  // );
                }),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 4),
                            child: ContentText(
                                text: "IEEE Spectrum", size: Size.large),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 4, bottom: 4),
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
                      for (var i = 0; i < 4; i++)
                        Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                        margin:
                                            const EdgeInsets.only(bottom: 4),
                                        child:
                                            const Text("Summarize the topic"),
                                      ),
                                      const ContentText(
                                          text: "Monday, 20:00",
                                          size: Size.tiny),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              margin: 20,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBarModalBottomSheet(
          context: context,
          builder: (context) => const NewReminder(),
          expand: true,
        ),
        child: const Icon(Icons.add_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
