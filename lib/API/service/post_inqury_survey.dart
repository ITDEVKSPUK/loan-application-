import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/history_models.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';

class PostInqury {
  final dio = DioClient.dio;
  Future<InquirySurveyModel> fetchInqury({
    required String officeId,
    required String trxSurvey,
  }) async {
    final timestamp =
        '${DateTime.now().toUtc().toIso8601String().split('.').first}Z';

    final headers = {
      'ICS-Wipala': 'sastra.astana.dwipangga',
      'ICS-Timestamp': timestamp,
      'ICS-Signature': 'sandbox.rus2025',
      'Content-Type': 'application/json',
    };

    final body = {
      'Office_ID': officeId,
      'trx_survey': trxSurvey,
    };

    try {
      final response = await dio.post(
        '/sandbox.ics/v1.0/v1/survey/inquiry',
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