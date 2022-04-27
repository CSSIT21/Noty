class NoteDetail {
  String type;
  String detail;
  String createdAt;
  String reminderId;
  List<String> tags;

  NoteDetail(
      {required this.type,
      required this.detail,
      required this.createdAt,
      required this.reminderId,
      required this.tags});

  factory NoteDetail.fromJson(Map<String, dynamic> json) {
    return NoteDetail(
        type: json["type"],
        detail: json["detail"],
        createdAt: json["created_at"],
        reminderId: json["reminder_id"],
        tags: List<String>.from(json["tags"].map((x) => x)));
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "detail": detail,
      "created_at": createdAt,
      "reminder_id": reminderId,
      "tags": List<dynamic>.from(tags.map((x) => x))
    };
  }
}
