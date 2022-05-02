import 'package:dio/dio.dart';
import 'package:noty_client/config/api.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/models/response/me/me_infomation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  static Future<dynamic> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(apiEndpoint + "/me/info",
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      MeResponse res = MeResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> updateProfile(
      String firstname, String lastname) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().patch(apiEndpoint + "/me/edit/name",
          data: {"firstname": firstname, "lastname": lastname},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      InfoResponse res = InfoResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> updatePassword(
      String newPass, String currentPass) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().patch(apiEndpoint + "/me/edit/password",
          data: {"new_password": newPass, "current_password": currentPass},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      InfoResponse res = InfoResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }
}
