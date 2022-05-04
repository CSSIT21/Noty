import 'package:noty_client/models/response/reminder/reminder.dart';

class NoteReminders {
  String noteId;
  String title;
  List<NoteReminderData> reminders;

  NoteReminders({
    required this.noteId,
    required this.title,
    required this.reminders,
  });

  factory NoteReminders.fromJson(Map<String, dynamic> json) {
    var reminderDatas = json['reminders'] as List;
    List<NoteReminderData> tempDataList =
        reminderDatas.map((e) => NoteReminderData.fromJson(e)).toList();

    return NoteReminders(
      noteId: json['note_id'],
      title: json['title'],
      reminders: tempDataList,
    );
  }
}
