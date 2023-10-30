import 'dart:convert';
// dio
import "package:dio/dio.dart";
import '../services/secret.dart';

class RapatServices {
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
    try {
      response = await dio.get(
        url,
        data: {
          'id_agenda': idAgenda,
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
        final Map<String, dynamic> responseData = response.data;
        print(responseData);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = response.data;
        print(responseData);
        return responseData;
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }

  absensiStore({kodeRapat, nip, noHp, nama, asalInstansi}) async {
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
    try {
      response = await dio.post(
        url,
        data: {
          'kode_rapat': kodeRapat,
          'nip': nip,
          'no_hp': noHp,
          'nama': nama,
          'alamat': asalInstansi,
          'signatureData': 'ttd'
        },
      );
      if (response.statusCode == 200) {
        print(response.data);
        final Map<String, dynamic> responseData = response.data;
        print(responseData);
        return responseData;
      } else {
        final Map<String, dynamic> responseData = response.data;
        print(responseData);
        return responseData;
      }
      // return AgendaRapatModel.fromJson(response.data);
    } on DioException catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      throw Exception(error.response);
    }
  }
}
