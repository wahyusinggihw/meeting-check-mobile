import 'dart:convert';
import 'dart:developer';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:dio/dio.dart';
import 'package:meeting_check/models/agendarapatsearch_model.dart';
import 'package:meeting_check/models/agendarapatselesai_model.dart';
import 'package:meeting_check/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_check/services/secret.dart';

class AgendaRapatService extends Services {
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

    handleHttp(dio);

    idInstansi() {
      return user['kode_ukerja'].substring(0, 8);
    }

    nip() {
      return user['nip'];
    }

    // ignore: prefer_interpolation_to_compose_strings
    String url =
        '$apiURL/api/agenda-rapat/instansi/' + idInstansi() + '?nip=' + nip();
    // log(url);
    try {
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return [];
        } else {
          // final Map<String, dynamic> data =
          //     response.data['data'] as Map<String, dynamic>;
          // return data.entries
          //     .map((entry) => AgendaRapatModel.fromJson(entry.value))
          //     .toList();
          final List<dynamic> dataList = response.data['data'] as List<dynamic>;
          return dataList
              .map((entry) =>
                  AgendaRapatModel.fromJson(entry as Map<String, dynamic>))
              .toList();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  Future<List<AgendaRapatSelesaiModel>> getAgendaRapatSelesai() async {
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

    handleHttp(dio);

    idInstansi() {
      return user['kode_ukerja'].substring(0, 8);
    }

    nip() {
      return user['nip'];
    }

    // ignore: prefer_interpolation_to_compose_strings
    String url = '$apiURL/api/agenda-rapat/instansi/selesai/' +
        idInstansi() +
        '?nip=' +
        nip();
    // log(url);
    try {
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return [];
        } else {
          // final Map<String, dynamic> data =
          //     response.data['data'] as Map<String, dynamic>;
          // return data.entries
          //     .map((entry) => AgendaRapatModel.fromJson(entry.value))
          //     .toList();
          final List<dynamic> dataList = response.data['data'] as List<dynamic>;
          return dataList
              .map((entry) => AgendaRapatSelesaiModel.fromJson(
                  entry as Map<String, dynamic>))
              .toList();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  Future<List<AgendaRapatSearchModel>> getAgendaRapatSearch() async {
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

    handleHttp(dio);

    // idInstansi() {
    //   return user['kode_ukerja'].substring(0, 8);
    // }

    nip() {
      return user['nip'];
    }

    // ignore: prefer_interpolation_to_compose_strings
    String url = '$apiURL/api/agenda-rapat/search?nip=' + nip();
    // log(url);
    try {
      final Response response = await dio.get(url);
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return [];
        } else {
          // final Map<String, dynamic> data =
          //     response.data['data'] as Map<String, dynamic>;
          // return data.entries
          //     .map((entry) => AgendaRapatModel.fromJson(entry.value))
          //     .toList();
          final List<dynamic> dataList = response.data['data'] as List<dynamic>;
          return dataList
              .map((entry) => AgendaRapatSearchModel.fromJson(
                  entry as Map<String, dynamic>))
              .toList();
        }
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (error, stacktrace) {
      log('Exception occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
