class NoteReminderData {
  String id;
  String createdAt;
  String updatedAt;
  String userId;
  String title;
  String noteId;
  String description;
  String remindDate;
  bool success;

  NoteReminderData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.title,
    required this.noteId,
    required this.description,
    required this.remindDate,
    required this.success,
  });

  factory NoteReminderData.fromJson(Map<String, dynamic> json) {
    return NoteReminderData(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      userId: json['user_id'],
      title: json['title'],
      noteId: json['note_id'],
      description: json['description'] ?? "",
      remindDate: json['remind_date'] ?? "",
      success: json['success'],
    );
  }
}
