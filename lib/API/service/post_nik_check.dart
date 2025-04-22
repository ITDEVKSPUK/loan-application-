import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class CheckNik {
  final storage = GetStorage();
  final String baseUrl =
      "http://36.92.75.178:8001/sandbox.ics/v1.0/inquiry-anggota";
  late final String secretKey;
  final Dio dio = Dio();
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

  Future<void> _fetchData() async {
    const url = 'http://36.92.75.178:8001/sandbox.ics/v1.0/inquiry-anggota';

    final box = GetStorage();

    String token = box.read("dtsessionid");
    String path = "/sandbox.ics/v1.0/inquiry-anggota";
    String verb = "POST";
    String timestamp =
        DateTime.now().toUtc().toIso8601String().split('.').first + 'Z';
    String payload =
        'path=$path&verb=$verb&token=$token&timestamp=$timestamp&body=';

    String icsSignature = generateSignature(
      payload: payload,
    );
    final headers = {
      "Content-Type": "application/json",
      "ICS-Timestamp": timestamp,
      "ICS-Wipala": "sastra.astana.dwipangga",
      "ICS-Signature": icsSignature,
      "Cookie": "$token",
    };

    final body = {
      "id_legal": 3319123456,
      "Office_ID": "000",
      "id_search": {"value": "3315194203940003", "type": "smart"}
    };

    try {
      final response = await Dio().post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(body),
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final errorData = e.response!.data;
          if (errorData is Map<String, dynamic> &&
              errorData.containsKey('message')) {
            throw Exception(errorData['message']);
          }
        } else {
          throw Exception('Network error: ${e.message}');
        }
      }
    }
  }
}
