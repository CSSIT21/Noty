import 'package:noty_client/models/response/notes/note_detail_details.dart';

class NoteDetailResponse {
  bool success;
  String code;
  NoteDetailData data;

  NoteDetailResponse(
      {required this.success, required this.code, required this.data});

  factory NoteDetailResponse.fromJson(Map<String, dynamic> json) {
    return NoteDetailResponse(
      success: json['success'],
      code: json['code'],
      data: NoteDetailData.fromJson(json['data']),
    );
  }
}

class NoteDetailData {
  String id;
  String updatedAt;
  String title;
  String? folderId;
  List<String>? tags;
  List<NoteDetailDataDetails> details;

  NoteDetailData({
    required this.id,
    required this.updatedAt,
    required this.title,
    this.folderId,
    this.tags,
    required this.details,
  });

  factory NoteDetailData.fromJson(Map<String, dynamic> json) {
    // var noteList = json['data'] != null ? json['data'] as List : [];

    var noteDetailsDataList = json['data'] != null ? json['data'] as List : [];
    List<NoteDetailDataDetails> tempDataList = noteDetailsDataList
        .map((e) => NoteDetailDataDetails.fromJson(e))
        .toList();

    return NoteDetailData(
      id: json['note_id'],
      updatedAt: json['updated_at'],
      title: json['title'],
      folderId: json['folder_id'],
      tags: json["tags"] != null
          ? List<String>.from(json["tags"].map((x) => x))
          : [],
      details: tempDataList,
    );
  }
}
