import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class getDocAgun {
  static final signatureController = Get.find<SignatureController>();
  static final Dio _dio = DioClient.dio;
  static const path = '/sandbox.ics/v1.0/reff';

  static Future<List<dynamic>> fetchAgunan() async {
    try {
      final headers = signatureController.generateHeaders(
        path: '$path/ref_catagunan',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/ref_catagunan',
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
      final headers = signatureController.generateHeaders(
        path: '$path/ref_catdocumen',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/ref_catdocumen',
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
