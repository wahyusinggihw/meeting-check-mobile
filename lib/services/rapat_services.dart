import 'dart:convert';
import 'dart:developer';
// dio
import 'package:dio/dio.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:meeting_check/services/agendarapat_services.dart';
import 'package:meeting_check/services/services.dart';
import '../services/secret.dart';

class RapatServices extends Services {
  AgendaRapatService agendaRapatService = AgendaRapatService();
  Future<Map<String, dynamic>> getAgendaRapatByKode(String kodeRapat) async {
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

    final String url = '$apiURL/api/agenda-rapat/scan/$kodeRapat';

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
      log('DioException occurred: ${error.response}');
      throw Exception(error.response);
    }
  }

  getRapatByKode(kodeRapat) async {
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
    handleHttp(dio);
    String url = '$apiURL/api/agenda-rapat/scan/$kodeRapat';
    // print(kodeRapat);
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
      log('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  getStatusRapat(kodeRapat) {
    var $data = getRapatByKode(kodeRapat);
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
    handleHttp(dio);
    String url = '$apiURL/api/daftar-hadir/store';
    // print(signatureData);
    try {
      response = await dio.post(
        url,
        data: {
          'kode_rapat': kodeRapat,
          'nip': nip,
          'no_hp': noHp,
          'nama': nama,
          'status': "pegawai",
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
      log('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
