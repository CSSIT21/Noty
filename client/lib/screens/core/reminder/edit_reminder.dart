import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/services/providers/providers.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';
import 'package:provider/provider.dart';

class EditReminder extends StatefulWidget {
  final String title;
  final String details;
  final String date;
  final String reminderId;
  const EditReminder(
      {Key? key,
      required this.title,
      required this.details,
      required this.date,
      required this.reminderId})
      : super(key: key);

  @override
  State<EditReminder> createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  late DateTime selectedDate;
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
              initialDateTime:
                  selectedDate == DateTime.parse("0001-01-01T00:00:00Z")
                      ? DateTime.now()
                      : selectedDate,
              minimumYear: DateTime.now().year,
              maximumYear: 2099,
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _detailsController = TextEditingController(text: widget.details);
    selectedDate = DateTime.parse(widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: widget.title),
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
            onPressed: () {
              if (_titleController.text.isNotEmpty) {
                context.read<ReminderProvider>().editReminder(
                    _titleController.text,
                    _detailsController.text,
                    selectedDate.toIso8601String(),
                    widget.reminderId,
                    context);
                Navigator.pop(context);
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
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.normal,
                color: ThemeConstant.colorPrimaryLight,
              ),
            ),
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
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
                      isDateSelected || widget.date != "0001-01-01T00:00:00Z"
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
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    context
                        .read<ReminderProvider>()
                        .deleteReminder(widget.reminderId, context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
