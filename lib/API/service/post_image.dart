import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';

class SurveyUploadService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://36.92.75.178:8001'));
  final GetStorage storage = GetStorage();

  final String path = '/sandbox.ics/v1.0/v1/survei/doc-upload';

  String get _secretKey => storage.read("encryptedUsername") ?? '';
  String get _token => storage.read("session_id") ?? '';

  String generateSignature({
    required String payload,
  }) {
    final key = utf8.encode(_secretKey);
    final bytes = utf8.encode(payload);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }

  Future<Response> uploadSurveyDocuments({
    required String officeId,
    required int cifId,
    required int trxSurvey,
    required File doc005,
    required File doc027,
  }) async {
    // Timestamp ISO format + UTC
    final timestamp =
        '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00';

    // JSON Body (but still included as part of FormData)
    final bodyJson = {
      "Office_ID": officeId,
      "cif_id": cifId,
      "trx_survey": trxSurvey,
    };

    // Signature payload
    final payload =
        'path=$path&verb=POST&token=$_token&timestamp=$timestamp&body=';
    final icsSignature = generateSignature(payload: payload);

    // Headers
    final headers = {
      "ICS-Wipala": "sastra.astana.dwipangga",
      "ICS-Timestamp": timestamp,
      "ICS-Signature": icsSignature,
      "Content-Type": "application/json;multipart/form-data",
    };

    // Multipart Form Data
    final formData = FormData.fromMap({
      'body': jsonEncode(bodyJson),
      'doc-005': await MultipartFile.fromFile(doc005.path,
          filename: basename(doc005.path)),
      'doc-027': await MultipartFile.fromFile(doc027.path,
          filename: basename(doc027.path)),
    });

    try {
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Upload failed: ${e.response?.data ?? e.message} (${e.response?.statusCode})');
    }
  }
}
