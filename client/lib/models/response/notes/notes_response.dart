import 'package:noty_client/models/response/notes/folder_data.dart';
import 'package:noty_client/models/response/notes/note_data.dart';

class NotesResponse {
  bool success;
  String code;
  NotesResponseData data;

  NotesResponse(
      {required this.code, required this.success, required this.data});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    return NotesResponse(
        success: json['success'],
        code: json['code'],
        data: NotesResponseData.fromJson(json['data']));
  }
}

class NotesResponseData {
  List<FolderData> folders;
  List<NoteData> notes;

  NotesResponseData({required this.folders, required this.notes});

  factory NotesResponseData.fromJson(Map<String, dynamic> json) {
    var folderList = json['folders'] as List;
    var noteList = json['notes'] as List;

    List<FolderData> tempFolders =
        folderList.map((e) => FolderData.fromJson(e)).toList();
    List<NoteData> tempNotes =
        noteList.map((e) => NoteData.fromJson(e)).toList();

    return NotesResponseData(
      folders: tempFolders,
      notes: tempNotes,
    );
  }
}
