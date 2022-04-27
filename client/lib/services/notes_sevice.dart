import '../models/folder.dart';
import '../models/note_detail.dart';
import '../models/notes.dart';
import 'package:dio/dio.dart';

class GetNoteService {
  static Future<Map<String, dynamic>> getData() async {
    Response response =
        await Dio().get('https://mock-noty.mixkoap.com/test-payload.json');
    return response.data;
  }

  static List<Folder> getFolders(data) {
    List<dynamic> foldersData = data["folders"];
    List<Folder> tempFolders = foldersData.map((folder) {
      return Folder(
          folderId: folder["folder_id"],
          title: folder["title"],
          count: folder["count"]);
    }).toList();
    return tempFolders;
  }

  static List<Notes> getNotes(data) {
    List<dynamic> notesData = data["notes"];
    List<Notes> tempNotes = notesData.map((note) {
      List<dynamic> tempNoteDetail = note["note_detail"];
      List<NoteDetail> noteDetails = tempNoteDetail.map((noteDetail) {
        List<dynamic> tempTags = noteDetail["tags"] ?? [];
        List<String> tags = tempTags.map((tag) => tag.toString()).toList();
        return NoteDetail(
            type: noteDetail["type"],
            detail: noteDetail["detail"] ?? "",
            createdAt: noteDetail["created_at"] ?? "",
            reminderId: noteDetail["reminder_id"] ?? "",
            tags: tags);
      }).toList();
      return Notes(
        id: note["id"],
        userId: note["user_id"],
        title: note["title"],
        folderId: note["folder_id"],
        createdAt: note["created_at"],
        noteDetail: noteDetails,
      );
    }).toList();
    return tempNotes;
  }
}
