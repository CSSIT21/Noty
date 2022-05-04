class AddReminderResponse {
  bool success;
  String code;
  AddReminderIdResponse data;

  AddReminderResponse({
    required this.success,
    required this.code,
    required this.data,
  });

  factory AddReminderResponse.fromJson(Map<String, dynamic> json) {
    return AddReminderResponse(
      success: json['success'],
      code: json['code'],
      data: AddReminderIdResponse.fromJson(json['data']),
    );
  }
}

class AddReminderIdResponse {
  String reminderId;

  AddReminderIdResponse({
    required this.reminderId,
  });

  factory AddReminderIdResponse.fromJson(Map<String, dynamic> json) {
    return AddReminderIdResponse(reminderId: json["reminder_id"]);
  }
}
