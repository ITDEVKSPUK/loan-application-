import 'package:dio/dio.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/put_models_update.dart';

class PutUpdateSurvey {
  final dio = DioClient.dio;

  Future<dynamic> putUpdateSurvey({
    required String surveyId,
    required Map<String, dynamic> surveyData,
  }) async {
    try {
      final timestamp =
          '${DateTime.now().toUtc().toIso8601String().split('.').first}Z';
      final putModelsUpdate = PutModelsUpdate.fromJson(surveyData);

      final response = await dio.put(
        '/sandbox.ics/v1.0/survey/debitur/maker',
        data: putModelsUpdate.toJson(),
        options: Options(
          headers: {
            'ICS-Wipala': 'sastra.astana.dwipangga',
            'ICS-Timestamp': timestamp,
            'ICS-Signature': 'sandbox.rus2025',
            'Content-Type': 'application/json',
          },
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
