class MeData {
  String email;
  String firstname;
  String lastname;
  String avatarUrl;
  String userId;
  int notes;
  int folders;
  int reminders;
  int tags;

  MeData(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.avatarUrl,
      required this.userId,
      required this.notes,
      required this.folders,
      required this.reminders,
      required this.tags});

  factory MeData.fromJson(Map<String, dynamic> json) {
    return MeData(
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        avatarUrl: json["avatar_url"] ?? "",
        userId: json["user_id"],
        notes: json["notes"],
        folders: json["folders"],
        reminders: json["reminders"],
        tags: json["tags"]);
  }
}

class MeResponse {
  bool success;
  String code;
  MeData data;

  MeResponse({required this.success, required this.code, required this.data});

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
        success: json['success'],
        code: json['code'],
        data: MeData.fromJson(json['data']));
  }
}
