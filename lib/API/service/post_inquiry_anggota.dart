import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';

class Post_anggota {
  final dio = DioClient.dio;
  Future<InquiryAnggota> fetchInquryanggota({
    required String idLegal,
    required String officeId,
    required String idSearch,
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
      "id_legal": idLegal,
      "Office_ID": officeId,
      "id_search": {"value": idSearch, "type": "smart"}
    };

    try {
      final response = await dio.post(
        '/sandbox.ics/v1.0/inquiry-anggota',
        data: body,
        options: Options(headers: headers),
      );

      print('Response data: ${response.data}');

      return InquiryAnggota.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch history: ${e.response?.data ?? e.message} (${e.response?.statusCode})',
      );
    }
  }
}
