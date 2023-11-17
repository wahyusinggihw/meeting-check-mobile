import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/io.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import "package:dio/dio.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_check/services/secret.dart';

class AgendaRapatService {
  handleHttp(dio) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
  }

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

    // ignore: prefer_interpolation_to_compose_strings
    String url = '$apiURL/api/agenda-rapat/instansi/' + idInstansi();
    // log(url);
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
      log('Exception occurred: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
