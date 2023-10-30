import 'dart:convert';

import 'package:meeting_check/models/agendarapat_model.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meeting_check/services/secret.dart';

class AgendaRapatService {
  Future<List<AgendaRapatModel>> getAgendaRapat() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());
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

    _idInstansi() {
      if (user != null) {
        return user['kode_ukerja'];
      }
    }

    String url = '$apiURL/api/agenda-rapat/' + _idInstansi();
    print(url);
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        // print(response.statusMessage);
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data.map((json) => AgendaRapatModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data');
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
