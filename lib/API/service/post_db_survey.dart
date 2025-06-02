import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class PostSurveyService {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/survey/debitur/maker";

  Future<Response> postSurvey({
    required int cifId,
    required int idLegal,
    required String officeId,
    required Map<String, dynamic> application,
    required Map<String, dynamic> collateral,
    required Map<String, dynamic> additionalInfo,
  }) async {
    final headers = signatureController.generateHeaders(
      path: path,
      verb: "POST",
    );

    final body = {
      "cif_id": cifId,
      "id_legal": idLegal,
      "Office_ID": officeId,
      "application": application,
      "collateral": collateral,
      "additionalinfo": additionalInfo,
    };

    try {
      final response = await dio.post(
        path,
        data: body,
        options: Options(headers: headers),
      );
      return response;
    } catch (e) {
      print("Error posting survey: $e");
      rethrow;
    }
  }
}
