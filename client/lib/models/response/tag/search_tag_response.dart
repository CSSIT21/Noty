import 'package:noty_client/models/response/notes/note_data.dart';

class SearchTagResponse {
  bool success;
  String code;
  List<NoteData> notes;

  SearchTagResponse({
    required this.success,
    required this.code,
    required this.notes,
  });

  factory SearchTagResponse.fromJson(Map<String, dynamic> json) {
    var noteList = json['data'] != null ? json['data'] as List : [];
    List<NoteData> tempNotes =
        noteList.map((e) => NoteData.fromJson(e)).toList();

    return SearchTagResponse(
      success: json['success'],
      code: json['code'],
      notes: tempNotes,
    );
  }
}
