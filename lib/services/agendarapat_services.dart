import 'dart:convert';

import 'package:meeting_check/models/agendarapat_model.dart';
import "package:dio/dio.dart";

import 'package:meeting_check/services/secret.dart';

class AgendaRapatService {
  Future<List<AgendaRapatModel>> getAgendaRapat() async {
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

    String url = '$apiURL/api/agenda-rapat';
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        // print(response.statusMessage);
        final List<dynamic> data = response.data['data'];
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
