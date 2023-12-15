import 'dart:convert';
import 'dart:developer';
// dio
import 'package:dio/dio.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:meeting_check/services/agendarapat_services.dart';
import 'package:meeting_check/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/secret.dart';

class RapatServices extends Services {
  AgendaRapatService agendaRapatService = AgendaRapatService();

  // untuk scan qr code
  Future<Map<String, dynamic>> getAgendaRapatByKode(String kodeRapat) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final String? userData = localStorage.getString('user');

    if (userData == null) {
      // Handle the case where 'user' data is null, which could happen if the user is not logged in.
      return {'error': true, 'message': 'Empty response data'};
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

    nip() {
      return user['nip'];
    }

    final String url = '$apiURL/api/agenda-rapat/scan/$kodeRapat?nip=' + nip();
    print(url);

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        if (response.data['error'] == true) {
          // Error response
          final String message = response.data['message'];
          return {'error': true, 'message': message};
        }
        final List<dynamic> responseDataList = response.data['data'];

        // Check if responseDataList is not empty before accessing the first item
        if (responseDataList.isNotEmpty) {
          final Map<String, dynamic> responseData = responseDataList.first;

          if (responseData.containsKey('error') &&
              responseData['error'] == true) {
            // Error response
            final String message = responseData['message'];
            return {'error': true, 'message': message};
          }
          print(responseData['hadir']);
          // Success response
          final AgendaRapatModel agendaRapat =
              AgendaRapatModel.fromJson(responseData);
          return {
            'error': false,
            'agendaRapat': responseData,
            'formData': agendaRapat,
            'hadir': responseData['hadir']
          };
        } else {
          // Handle the case where responseDataList is empty
          return {'error': true, 'message': 'Empty response data'};
        }
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
