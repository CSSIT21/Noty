class Folder {
  String? folderId;
  String title;
  int count;

  Folder({
    this.folderId,
    required this.title,
    required this.count,
  });

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
        folderId: json["folder_id"],
        title: json["title"],
        count: json["count"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": folderId,
      "title": title,
      "count": count,
    };
  }
}
