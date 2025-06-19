import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get_storage/get_storage.dart';

class SignatureController {
  final storage = GetStorage();

  /// Generates a timestamp in UTC ISO format
  String _generateTimestamp() {
    return '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00';
  }

  /// Generates the HMAC-SHA256 Base64 signature with internal token fetch
  Map<String, String> generateHeaders({
    required String path,
    required String verb,
    String body = '',
  }) {
    final token = storage.read('session_id');
    final encryptedUsername = storage.read('encryptedUsername');

    if (token == null || encryptedUsername == null) {
      throw Exception('Missing session_id or encryptedUsername in storage');
    }

    final timestamp = _generateTimestamp();
    final payload =
        'path=$path&verb=$verb&token=$token&timestamp=$timestamp&body=$body';
    print("Payload: $payload");
    print("Encrypted Username: $encryptedUsername");
    var key = utf8.encode(encryptedUsername);
    var bytes = utf8.encode(payload);
    var hmacSha256 = Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    var signature = base64.encode(digest.bytes);

    return {
      'ICS-Timestamp': timestamp,
      'ICS-Signature': signature,
    };
  }
}
