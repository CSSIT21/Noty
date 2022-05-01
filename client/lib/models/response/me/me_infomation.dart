class MeInformationResponse {
  String email;
  String firstname;
  String lastname;
  String pictureId;
  String userId;
  String notes;
  String folders;
  String reminders;
  String tags;

  MeInformationResponse(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.pictureId,
      required this.userId,
      required this.notes,
      required this.folders,
      required this.reminders,
      required this.tags});

  factory MeInformationResponse.fromJson(Map<String, dynamic> json) {
    return MeInformationResponse(
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
