class AddNoteResponse {
  bool success;
  String code;
  String info;
  AddNoteData data;

  AddNoteResponse({
    required this.success,
    required this.code,
    required this.info,
    required this.data,
  });

  factory AddNoteResponse.fromJson(Map<String, dynamic> json) {
    return AddNoteResponse(
      success: json["success"],
      code: json["code"] ?? "",
      info: json["info"],
      data: AddNoteData.fromJson(json['data']),
    );
  }
}

class AddNoteData {
  String noteId;

  AddNoteData({
    required this.noteId,
  });

  factory AddNoteData.fromJson(Map<String, dynamic> json) {
    return AddNoteData(noteId: json['note_id']);
  }
}
