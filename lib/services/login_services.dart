import 'dart:convert';

import 'package:meeting_check/models/user_model.dart';
import 'package:meeting_check/services/secret.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  login(data) async {
    final Response response;
    final Dio dio = Dio(
      BaseOptions(
        headers: {
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$apiUsername:$apiPassword'))}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    String url = '$apiURL/api/login';
    try {
      response = await dio.post(
        url,
        data: data,
      );
      if (response.statusCode == 200) {
        print(response.data);
        return response.data;
        // return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        return response.data;
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('islogin');
  }
}
