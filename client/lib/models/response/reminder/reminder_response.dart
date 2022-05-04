import 'package:noty_client/models/response/reminder/independent_reminder.dart';
import 'package:noty_client/models/response/reminder/notes_reminder.dart';

class ReminderResponse {
  bool success;
  String code;
  ReminderResponseData data;

  ReminderResponse(
      {required this.success, required this.code, required this.data});

  factory ReminderResponse.fromJson(Map<String, dynamic> json) {
    return ReminderResponse(
      success: json['success'],
      code: json['code'],
      data: ReminderResponseData.fromJson(json['data']),
    );
  }
}

class ReminderResponseData {
  List<IndependentReminder> independentReminders;
  List<NoteReminders> notesReminders;

  ReminderResponseData(
      {required this.independentReminders, required this.notesReminders});

  factory ReminderResponseData.fromJson(Map<String, dynamic> json) {
    var indepenReminders = json['independent_reminders'] as List;
    var notesReminder = json['notes_reminders'] as List;
    List<IndependentReminder> tempIndepenList =
        indepenReminders.map((e) => IndependentReminder.fromJson(e)).toList();
    List<NoteReminders> tempNotesList =
        notesReminder.map((e) => NoteReminders.fromJson(e)).toList();

    return ReminderResponseData(
      independentReminders: tempIndepenList,
      notesReminders: tempNotesList,
    );
  }
}
