import 'package:dio/dio.dart';
import 'package:noty_client/config/api.dart';
import 'package:noty_client/models/response/account/account_response.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  static Future<dynamic> login(String email, String password) async {
    try {
      Response response =
          await Dio().post(apiEndpoint + '/account/login', data: {
        'email': email,
        'password': password,
      });
      LoginResponse res = LoginResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', res.data.token);
      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> register(
      String firstname, String lastname, String email, String password) async {
    try {
      Response response =
          await Dio().post(apiEndpoint + '/account/register', data: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
      });
      LoginResponse res = LoginResponse.fromJson(response.data);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', res.data.token);
      return true;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
  }
}
