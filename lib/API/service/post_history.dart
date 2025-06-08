import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class HistoryService {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/v1/survey/report";
  Future<Response> fetchHistoryDebitur({
    required String officeId,
    required DateTime fromDateTime,
    required DateTime toDateTime,
  }) async {
    final headers = signatureController.generateHeaders(
      path: path,
      verb: "POST",
    );
    final body = {
      'Office_ID': officeId,
      'fromDateTime': fromDateTime.toIso8601String(),
      'toDateTime': toDateTime.toIso8601String(),
    };
    try {
      final response = await dio.post(
        path,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to fetch history: ${e.response?.data ?? e.message}${e.response?.statusCode}');
    }
  }
}
