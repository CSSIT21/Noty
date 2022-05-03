class FolderData {
  String folderId;
  String name;
  int noteCount;

  FolderData(
      {required this.folderId, required this.name, required this.noteCount});

  factory FolderData.fromJson(Map<String, dynamic> json) {
    return FolderData(
        folderId: json["folder_id"],
        name: json["name"],
        noteCount: json["note_count"]);
  }
}
