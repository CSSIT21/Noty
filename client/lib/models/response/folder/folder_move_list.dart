class FolderMoveList {
  String folderId;
  String name;

  FolderMoveList({
    required this.folderId,
    required this.name,
  });

  factory FolderMoveList.fromJson(Map<String, dynamic> json) {
    return FolderMoveList(folderId: json["folder_id"], name: json["name"]);
  }
}

class FolderMoveListResponse {
  bool success;
  String code;
  List<FolderMoveList> data;

  FolderMoveListResponse(
      {required this.success, required this.code, required this.data});

  factory FolderMoveListResponse.fromJson(Map<String, dynamic> json) {
    return FolderMoveListResponse(
        success: json["success"], code: json["code"], data: json["data"]);
  }
}
/*
{
  success: true,
  code: "",
  data: [
    {
      folderId: ""
      name: ""
    }
  ]
}*/
