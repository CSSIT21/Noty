import 'package:dio/dio.dart';
import 'package:noty_client/constants/environment.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/folder/folder_move_list.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderService {
  static Future<dynamic> add(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      var response = await Dio().post(
          EnvironmentConstant.internalApiPrefix + "/folder/add",
          data: {'name': name},
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

  static Future<dynamic> edit(String folderId, String newName) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      var response = await Dio().patch(
          EnvironmentConstant.internalApiPrefix + "/folder/edit",
          data: {'folder_id': folderId, 'new_name': newName},
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

  static Future<dynamic> delete(String folderId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      var response = await Dio().delete(
          EnvironmentConstant.internalApiPrefix + "/folder/delete",
          data: {'folder_id': folderId},
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

  static Future<dynamic> list() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          EnvironmentConstant.internalApiPrefix + "/folder/list",
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      List<dynamic> tempFolderList = response.data["data"];
      List<FolderMoveList> folderMoveList = tempFolderList.map((folder) {
        return FolderMoveList(
            folderId: folder["folder_id"], name: folder["name"]);
      }).toList();
      FolderMoveListResponse res = FolderMoveListResponse(
          success: response.data["success"],
          code: response.data["code"],
          data: folderMoveList);
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
