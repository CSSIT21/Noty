import 'package:noty_client/constants/environment.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/tag/tag_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class TagService {
  static Future<dynamic> getTagData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          EnvironmentConstant.internalApiPrefix + "/tag/list",
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      TagResponse res = TagResponse.fromJson(response.data);
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
