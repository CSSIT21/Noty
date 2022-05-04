import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:noty_client/constants/theme.dart';
import 'package:noty_client/widgets/typography/appbar_text.dart';

class NewReminder extends StatefulWidget {
  const NewReminder({Key? key}) : super(key: key);

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  bool isButtonDisabled = false;
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  DateTime selectedDate = DateTime.now();
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
              initialDateTime: selectedDate,
              minimumYear: DateTime.now().year,
              maximumYear: 2099,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: isButtonDisabled
                ? null
                : () {
                    Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(
              "Add",
              style: !isButtonDisabled
                  ? TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: ThemeConstant.colorPrimaryLight)
                  : TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.normal,
                      color: ThemeConstant.textColorSecondary,
                    ),
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
                      isDateSelected
                          ? Text(
                              selectedDate.toString().substring(0, 16),
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
    );
  }
}
