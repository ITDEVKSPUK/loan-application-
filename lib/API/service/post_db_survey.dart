import 'package:dio/dio.dart';
import 'package:loan_application/API/dio/dio_client.dart';

class PostSurveyService {
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
    final headers = {
      'ICS-Wipala': 'sastra.astana.dwipangga',
      'ICS-Timestamp': DateTime.now().toUtc().toIso8601String(),
      'ICS-Signature': 'sandbox.rus2025',
    };

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
