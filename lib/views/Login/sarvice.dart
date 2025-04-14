import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_apllication/views/Login/models.dart';

class LoginService extends GetxService {
  final Dio _dio = Dio();
  final storage = GetStorage();

  // Gunakan kunci AES 32 byte (256-bit)
  static final _key = Key.fromUtf8('35argan1n9k4MulyanRahayu85uki396');

  // IV harus konsisten dengan enkripsi di server
  static final _iv = IV.fromUtf8('J9ja8Yn8fYQllwAA');

  final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  String _encrypt(String text) {
    final encrypted = _encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  Future<LoggedUser> login(String username, String password) async {
    const url = 'http://36.92.75.178:8001/system/users/logged';

    final headers = {
      "Content-Type": "application/json",
    };

    // Enkripsi username dan password sebelum dikirim ke server
    final encryptedUsername = _encrypt(username);
    final encryptedPassword = _encrypt(password);
    final encryptedSignature = _encrypt(jsonEncode({
      "app_version": "ics-sandbox/v1",
      "grantType": "client_credentials",
      "ido": "000"
    }));

    final body = {
      "username": encryptedUsername,
      "password": encryptedPassword,
      "signature": encryptedSignature,
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        storage.write('encryptedUsername', encryptedUsername);
        final rawCookie = response.headers['set-cookie']?.first;
        if (rawCookie != null) {
          final sessionId = rawCookie.split(';')[0];
          storage.write('dtsessionid', sessionId);
        }

        // Parse response data into LoggedUser model
        final responseData = response.data as Map<String, dynamic>;

        // Add session ID to the response data if not included
        if (!responseData.containsKey('SessionID') && rawCookie != null) {
          responseData['SessionID'] = rawCookie.split(';')[0];
        }

        return LoggedUser.fromJson(responseData);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final errorData = e.response!.data;
          if (errorData is Map<String, dynamic> &&
              errorData.containsKey('message')) {
            throw Exception(errorData['message']);
          }
        }
      }
      throw Exception('Error during login: ${e.toString()}');
    }
  }
}
