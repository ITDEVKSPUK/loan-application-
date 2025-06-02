import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/utils/signature_utils.dart';

class PostInqury {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/v1/survey/inquiry";
  Future<InquirySurveyModel> fetchInqury({
    required String officeId,
    required String trxSurvey,
  }) async {
    final headers = signatureController.generateHeaders(
      path: path,
      verb: "POST",
    );

    final body = {
      'Office_ID': officeId,
      'trx_survey': trxSurvey,
    };

    try {
      final response = await dio.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      if (response.data is Map<String, dynamic>) {
        print('Inquiry response data: ${response.data}');
        return InquirySurveyModel.fromJson(response.data);
      } else {
        print('Unexpected inquiry response: ${response.data}');
        throw Exception(
            'Invalid response format: Expected JSON, received ${response.data.runtimeType}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      throw Exception(
        'Failed to fetch inquiry: ${e.response?.data ?? e.message} (${e.response?.statusCode})',
      );
    }
  }
}
