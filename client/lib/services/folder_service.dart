import 'package:dio/dio.dart';
import 'package:noty_client/config/api.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/folder/folder_move_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolderService {
  static Future<dynamic> add(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      await Dio().post(apiEndpoint + "/folder/add",
          data: {'name': name},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
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
      await Dio().patch(apiEndpoint + "/folder/edit",
          data: {'folder_id': folderId, 'new_name': newName},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
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
      await Dio().delete(apiEndpoint + "/folder/delete",
          data: {'folder_id': folderId},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
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
      Response response = await Dio().get(apiEndpoint + "/folder/list",
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
