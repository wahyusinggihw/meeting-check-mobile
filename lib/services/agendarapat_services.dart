import 'dart:convert';

import 'package:meeting_check/models/agendarapat_model.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meeting_check/services/secret.dart';

class AgendaRapatService {
  Future<List<AgendaRapatModel>> getAgendaRapat() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final String? userData = localStorage.getString('user');

    if (userData == null) {
      // Handle the case where 'user' data is null, which could happen if the user is not logged in.
      return [];
    }

    final Map<String, dynamic> user = jsonDecode(userData);
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

    _idInstansi() {
      if (user != null) {
        return user['kode_ukerja'];
      }
    }

    String url = '$apiURL/api/agenda-rapat/get-by-instansi/' + _idInstansi();
    print(url);
    try {
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return [];
        } else {
          final List<dynamic> data = response.data['data'] as List<dynamic>;
          return data.map((json) => AgendaRapatModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (error, stacktrace) {
      print('Exception occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  // Future<Map<String, List<AgendaRapatModel>>> getAgendaRapat() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = jsonDecode(localStorage.getString('user').toString());
  //   final Response response;
  //   final Dio dio = Dio(
  //     BaseOptions(
  //       headers: {
  //         'Authorization':
  //             'Basic ${base64Encode(utf8.encode('$apiUsername:$apiPassword'))}',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //     ),
  //   );

  //   _idInstansi() {
  //     if (user != null) {
  //       return user['kode_ukerja'];
  //     }
  //   }

  //   String url = '$apiURL/api/agenda-rapat/' + _idInstansi();
  //   print(url);
  //   try {
  //     response = await dio.get(url);
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = response.data['data'];

  //       final List<dynamic> tersediaList = data['tersedia'] as List<dynamic>;
  //       final List<AgendaRapatModel> tersediaAgendaList = tersediaList
  //           .map((json) => AgendaRapatModel.fromJson(json))
  //           .toList();

  //       return {'tersedia': tersediaAgendaList};
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } on DioException catch (error, stacktrace) {
  //     print('Exception occurred: $error stackTrace: $stacktrace');
  //     throw Exception(error.response);
  //   }
  // }
}
