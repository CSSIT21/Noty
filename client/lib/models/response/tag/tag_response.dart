import 'package:noty_client/models/response/notes/note_data.dart';

class TagResponse {
  bool success;
  String code;
  TagData data;

  TagResponse({
    required this.success,
    required this.code,
    required this.data,
  });
  factory TagResponse.fromJson(Map<String, dynamic> json) {
    return TagResponse(
      success: json['success'],
      code: json['code'],
      data: TagData.fromJson(
        json['data'],
      ),
    );
  }
}

class TagData {
  List<String> tagName;
  List<TagListData> tagList;

  TagData({
    required this.tagList,
    required this.tagName,
  });

  factory TagData.fromJson(Map<String, dynamic> json) {
    var tagList = json['tags_list'] != null ? json['tags_list'] as List : [];
    List<TagListData> tempTagList =
        tagList.map((e) => TagListData.fromJson(e)).toList();

    return TagData(
      tagList: tempTagList,
      tagName: json["tags_name"] != null
          ? List<String>.from(json["tags_name"].map((x) => x))
          : [],
    );
  }
}

class TagListData {
  String name;
  List<NoteData> notes;

  TagListData({
    required this.name,
    required this.notes,
  });

  factory TagListData.fromJson(Map<String, dynamic> json) {
    var noteList = json['notes'] != null ? json['notes'] as List : [];
    List<NoteData> tempNotes =
        noteList.map((e) => NoteData.fromJson(e)).toList();

    return TagListData(
      name: json['name'],
      notes: tempNotes,
    );
  }
}
