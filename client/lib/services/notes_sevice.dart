import 'package:noty_client/constants/environment.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/folder/note_list.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/models/response/notes/add_note_response.dart';
import 'package:noty_client/models/response/notes/note_detail_data.dart';
import 'package:noty_client/models/response/notes/notes_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class NoteService {
  static Future<dynamic> getData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          EnvironmentConstant.internalApiPrefix + "/note/info",
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      NotesResponse res = NotesResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> getNoteListFolder(String folderId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(
          EnvironmentConstant.internalApiPrefix + "/note/info/folder",
          data: {'folder_id': folderId},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      NoteListFolderResponse res =
          NoteListFolderResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> getNoteDetail(String noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(
          EnvironmentConstant.internalApiPrefix + "/note/info/id",
          data: {'note_id': noteId},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      NoteDetailResponse res = NoteDetailResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> moveNote(String folderId, String noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().patch(
          EnvironmentConstant.internalApiPrefix + "/note/move",
          data: {'note_id': noteId, 'folder_id': folderId},
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

  static Future<dynamic> deleteNote(String noteId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().delete(
          EnvironmentConstant.internalApiPrefix + "/note/delete",
          data: {'note_id': noteId},
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

  static Future<dynamic> addNote(String folderId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(
          EnvironmentConstant.internalApiPrefix + "/note/add",
          data: {'folder_id': folderId},
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      AddNoteResponse res = AddNoteResponse.fromJson(response.data);
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
