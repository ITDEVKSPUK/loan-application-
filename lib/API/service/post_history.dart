  import 'package:dio/dio.dart';
  import 'package:loan_application/API/dio/dio_client.dart';

  class HistoryService {
    final dio = DioClient.dio;
    Future<Response> fetchHistoryDebitur({
      required String officeId,
      required DateTime fromDateTime,
      required DateTime toDateTime,
    }) async {
      final timestamp =
          '${DateTime.now().toUtc().toIso8601String().split('.').first}Z';

      final headers = {
        'ICS-Wipala': 'sastra.astana.dwipangga',
        'ICS-Timestamp': timestamp,
        'ICS-Signature': 'sandbox.rus2025',
      };
      final body = {
        'Office_ID': officeId,
        'fromDateTime': fromDateTime.toIso8601String(),
        'toDateTime': toDateTime.toIso8601String(),
      };
      try {
        final response = await dio.post(
          '/sandbox.ics/v1.0/v1/survey/report',
          data: body,
          options: Options(
            headers: headers,
          ),
        );
        print('sekarang ${timestamp}');
        return response;
      } on DioException catch (e) {
        throw Exception(
            'Failed to fetch history: ${e.response?.data ?? e.message}${e.response?.statusCode}');
      }
    }
  }
