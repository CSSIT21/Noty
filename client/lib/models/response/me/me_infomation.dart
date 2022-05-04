class MeData {
  String email;
  String firstname;
  String lastname;
  String pictureId;
  String userId;
  int notes;
  int folders;
  int reminders;
  int tags;

  MeData(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.pictureId,
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
        pictureId: json["picture_id"],
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
