import 'package:dio/dio.dart';
import 'package:noty_client/models/response/error/error_response.dart';
import 'package:noty_client/models/response/info_response.dart';
import 'package:noty_client/models/response/reminder/add_reminder.dart';
import 'package:noty_client/models/response/reminder/reminder_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/environment.dart';

class ReminderService {
  static Future<dynamic> getReminder() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().get(
          EnvironmentConstant.internalApiPrefix + "/reminder/info",
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      ReminderResponse res = ReminderResponse.fromJson(response.data);
      return res;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 401) {
        ErrorResponse error = ErrorResponse.fromJson(e.response?.data);
        return error;
      }
    }
    return "";
  }

  static Future<dynamic> editReminder(String title, String description,
      String noteId, String reminderId, String remindDate) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().patch(
          EnvironmentConstant.internalApiPrefix + "/reminder/edit",
          data: {
            "title": title,
            "description": description,
            "note_id": noteId,
            "reminder_id": reminderId,
            "remind_date": remindDate,
          },
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

  static Future<dynamic> deleteReminder(String reminderId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().delete(
          EnvironmentConstant.internalApiPrefix + "/reminder/info",
          data: {"reminder_id": reminderId},
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

  static Future<dynamic> addReminder(String title, String description,
      String noteId, String remindDate) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('user');
    try {
      Response response = await Dio().post(
          EnvironmentConstant.internalApiPrefix + "/reminder/info",
          data: {
            "title": title,
            "description": description,
            "note_id": noteId,
            "remind_date": remindDate,
          },
          options: Options(headers: {"Authorization": "Bearer " + userToken!}));
      AddReminderResponse res = AddReminderResponse.fromJson(response.data);
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
