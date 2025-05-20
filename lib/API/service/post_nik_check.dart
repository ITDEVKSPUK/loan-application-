import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/dio/dio_client.dart';

class CheckNik {
  final storage = GetStorage();
  final String path = "/sandbox.ics/v1.0/inquiry-anggota";
  late final String secretKey;
  final dio = DioClient.dio;

  CheckNik() {
    secretKey = storage.read("encryptedUsername");
  }

  String generateSignature({
    required String payload,
  }) {
    var key = utf8.encode(secretKey);
    var bytes = utf8.encode(payload);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return base64.encode(digest.bytes);
  }

  Future<Response> fetchNIK(String nik) async {
    final box = GetStorage();

    String token = box.read("session_id");
    String verb = "POST";
    final timestamp =
        '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00';
    String payload =
        'path=$path&verb=$verb&token=$token&timestamp=$timestamp&body=';

    String icsSignature = generateSignature(
      payload: payload,
    );
    final headers = {
      "ICS-Wipala": "sastra.astana.dwipangga",
      "ICS-Timestamp": timestamp,
      "ICS-Signature": 'sandbox.rus2025',
    };

    final body = {
      "id_legal": 3319123456,
      "Office_ID": "000",
      "id_search": {"value": nik, "type": "smart"}
    };

    try {
      final response = await dio.post(
        path,
        options: Options(headers: headers),
        data: body,
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      throw Exception(
          'Failed to fetch nik: ${e.response?.data ?? e.message}${e.response?.statusCode}');
    }
  }
}
