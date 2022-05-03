class NoteData {
  String noteId;
  String title;
  String updatedAt;
  bool hasReminder;
  List<String> tags;

  NoteData(
      {required this.noteId,
      required this.title,
      required this.updatedAt,
      required this.tags,
      required this.hasReminder});

  factory NoteData.fromJson(Map<String, dynamic> json) {
    return NoteData(
      noteId: json["note_id"],
      title: json["title"],
      updatedAt: json["updated_at"],
      hasReminder: json["has_reminder"],
      tags: json["tags"] != null
          ? List<String>.from(json["tags"].map((x) => x))
          : [],
    );
  }
}
