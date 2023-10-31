import 'dart:convert';
// dio
import "package:dio/dio.dart";
import 'package:meeting_check/models/agendarapat_model.dart';
import '../services/secret.dart';

class RapatServices {
  Future<Map<String, dynamic>> getAgendaRapatById(String idAgenda) async {
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

    final String url = '$apiURL/api/agenda-rapat/get-by-id/$idAgenda';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        if (responseData.containsKey('error') &&
            responseData['error'] == true) {
          // Error response
          final String message = responseData['message'];
          return {'error': true, 'message': message};
        }

        // Success response
        final AgendaRapatModel agendaRapat =
            AgendaRapatModel.fromJson(responseData['data']);
        return {'error': false, 'agendaRapat': agendaRapat};
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (error) {
      print('DioException occurred: ${error.response}');
      throw Exception(error.response);
    }
  }

  getRapatById(idAgenda) async {
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
    String url = '$apiURL/api/agenda-rapat/get-by-id/$idAgenda';
    print(idAgenda);
    try {
      response = await dio.get(url);
      if (response.statusCode == 200) {
        // print(response.data);
        final Map<String, dynamic> responseData = response.data;
        // print(responseData);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = response.data;
        // print(responseData);
        return responseData;
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  getStatusRapat(idAgenda) {
    var $data = getRapatById(idAgenda);
    return $data;
  }

  absensiStore({
    required kodeRapat,
    required nip,
    required noHp,
    required nama,
    required alamat,
    required asalInstansi,
    required signatureData,
  }) async {
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
    String url = '$apiURL/api/form-absensi-store';
    // print(signatureData);
    try {
      response = await dio.post(
        url,
        data: {
          'kode_rapat': kodeRapat,
          'nip': nip,
          'no_hp': noHp,
          'nama': nama,
          'alamat': alamat,
          'asal_instansi': asalInstansi,
          'signatureData': signatureData
        },
      );
      if (response.statusCode == 200) {
        // print(response.data);
        final Map<String, dynamic> responseData = response.data;
        // print(responseData);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = response.data;
        // print(responseData);
        return responseData;
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
