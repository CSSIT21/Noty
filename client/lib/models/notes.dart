import 'note_detail.dart';

class Notes {
  String id;
  String userId;
  String title;
  String folderId;
  String createdAt;
  List<NoteDetail> noteDetail;

  Notes(
      {required this.id,
      required this.userId,
      required this.title,
      required this.folderId,
      required this.createdAt,
      required this.noteDetail});

  factory Notes.fromJson(Map<String, dynamic> json) {
    var list = json['note_detail'] as List;
    List<NoteDetail> noteDetailList =
        list.map((i) => NoteDetail.fromJson(i)).toList();

    return Notes(
      id: json["id"],
      userId: json["user_id"],
      title: json["title"],
      folderId: json["folderId"],
      createdAt: json["created_at"],
      noteDetail: noteDetailList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "title": title,
      "folder_id": folderId,
      "crerated_at": createdAt,
      "note_detail": noteDetail
    };
  }
}
