class NoteDetailDataDetails {
  String type;
  DetailsData? data;

  NoteDetailDataDetails({required this.type, this.data});

  factory NoteDetailDataDetails.fromJson(Map<String, dynamic> json) {
    return NoteDetailDataDetails(
      type: json['type'],
      data: DetailsData.fromJson(json['data']),
    );
  }
  Map toJson() {
    return {
      'type': type,
      'data': data!.toJson(),
    };
  }
}

class DetailsData {
  String content;

  DetailsData({
    required this.content,
  });

  factory DetailsData.fromJson(Map<String, dynamic> json) {
    return DetailsData(
      content: json['content'],
    );
  }
  Map toJson() {
    return {
      'content': content,
    };
  }
}
