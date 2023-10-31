import 'dart:convert';
import 'dart:math';

import 'package:meeting_check/models/user_model.dart';
import 'package:meeting_check/services/secret.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future<Map<String, dynamic>> login(Map<String, dynamic> data) async {
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

    final String url = '$apiURL/api/login';

    try {
      final response = await dio.post(
        url,
        data: data,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('error') &&
            responseData['error'] == true) {
          // Error response
          final String message = responseData['message'];
          return {'error': true, 'message': message};
        }
        return {
          'status': true,
          'message': responseData['message'],
          'data': responseData['data']
        };
      } else {
        throw Exception('Failed to load data');
      }
    } on DioError catch (error, stacktrace) {
      print('DioException occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('islogin');
  }
}
