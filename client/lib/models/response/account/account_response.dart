class LoginData {
  String token;
  LoginData({required this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'],
    );
  }
}

class LoginResponse {
  bool success;
  String code;
  LoginData data;

  LoginResponse(
      {required this.success, required this.code, required this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        success: json['success'],
        code: json['code'],
        data: LoginData.fromJson(json['data']));
  }
}
