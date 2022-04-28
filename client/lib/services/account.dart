import 'package:dio/dio.dart';

import '../config/api.dart';

class AccountService {
  static void login(String email, String password) async {
    Response response = await Dio().post(apiEndpoint + '/account/login', data: {
      'email': email,
      'password': password,
    });
    print(response.data);
  }
}
