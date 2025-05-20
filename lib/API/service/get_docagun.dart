import 'package:dio/dio.dart';
import 'package:loan_application/API/dio/dio_client.dart';

class getDocAgun {
  static final Dio _dio = DioClient.dio;
  static const baseUrl = '/sandbox.ics/v1.0/reff';

  static final headers = {
    'ICS-Wipala': 'sastra.astana.dwipangga',
    'ICS-Timestamp':
        '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00',
  };
  static Future<List<dynamic>> fetchAgunan() async {
    try {
      final response = await _dio.get(
        '$baseUrl/ref_catagunan',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Gagal mengambil Agunan: ${response.statusCode}');
      }
    } catch (e) {
      print('Kesalahan saat mengambil Agunan: $e');
      return [];
    }
  }

  static Future<List<dynamic>> fetchDocuments() async {
    try {
      final response = await _dio.get(
        '$baseUrl/ref_catdocumen',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Gagal mengambil Dokumen: ${response.statusCode}');
      }
    } catch (e) {
      print('Kesalahan saat mengambil Dokumen: $e');
      return [];
    }
  }
}
