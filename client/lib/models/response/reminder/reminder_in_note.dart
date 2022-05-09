import 'package:noty_client/models/response/reminder/independent_reminder.dart';

class ReminderInNote {
  bool success;
  String code;
  IndependentReminder reminder;

  ReminderInNote({
    required this.success,
    required this.code,
    required this.reminder,
  });

  factory ReminderInNote.fromJson(Map<String, dynamic> json) {
    return ReminderInNote(
      success: json['success'],
      code: json['code'],
      reminder: IndependentReminder.fromJson(json['data']),
    );
  }
}
