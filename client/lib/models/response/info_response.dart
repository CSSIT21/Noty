class InfoResponse {
  bool success;
  String code;
  String info;

  InfoResponse({required this.success, required this.code, required this.info});

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(
        success: json["success"], code: json["code"] ?? "", info: json["info"]);
  }
}
