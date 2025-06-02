import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/put_models_update.dart';
import 'package:loan_application/utils/signature_utils.dart';

class PutUpdateSurvey {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/survey/debitur/maker";
  Future<dynamic> putUpdateSurvey({
    required String surveyId,
    required Map<String, dynamic> surveyData,
  }) async {
    try {
      final headers = signatureController.generateHeaders(
        path: path,
        verb: "PUT",
      );
      final putModelsUpdate = PutModelsUpdate.fromJson(surveyData);

      final response = await dio.put(
        path,
        data: putModelsUpdate.toJson(),
        options: Options(
          headers: headers,
        ),
      );

      print('Survey updated successfully: ${response.data}');
      return response.data;
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode}, ${e.response?.data}');
      throw Exception(
          'Failed to update survey: ${e.response?.data?['message'] ?? e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Failed to update survey: $e');
    }
  }
}
