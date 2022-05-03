import 'package:noty_client/models/response/notes/note_data.dart';

class NoteListFolderResponse {
  bool success;
  String code;
  List<NoteData> data;

  NoteListFolderResponse(
      {required this.code, required this.success, required this.data});

  factory NoteListFolderResponse.fromJson(Map<String, dynamic> json) {
    var noteList = json['data'] != null ? json['data'] as List : [];
    if (noteList.isEmpty) {
      return NoteListFolderResponse(
        success: json['success'],
        code: json['code'],
        data: [],
      );
    } else {
      List<NoteData> tempNotes =
          noteList.map((e) => NoteData.fromJson(e)).toList();
      return NoteListFolderResponse(
        success: json['success'],
        code: json['code'],
        data: tempNotes,
      );
    }
  }
}
