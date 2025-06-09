import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/login_models.dart';
import 'package:loan_application/utils/signature_utils.dart';

class LoginService {
  static final signatureController = Get.find<SignatureController>();
  final GetStorage storage = GetStorage();
  final Dio _dio = DioClient.dio;

  static final _key = Key.fromUtf8('35argan1n9k4MulyanRahayu85uki396');
  static final _iv = IV.fromUtf8('J9ja8Yn8fYQllwAA');
  final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  String _encrypt(String plain) {
    final encrypted = _encrypter.encrypt(plain, iv: _iv);
    return encrypted.base64;
  }

  Future<bool> login(String username, String password) async {
    const loginUrl = 'http://36.92.75.178:8001/system/users/logged';

    final body = {
      "username": _encrypt(username),
      "password": _encrypt(password),
      "signature": _encrypt(jsonEncode({
        "app_version": "ics-sandbox/v1",
        "grantType": "client_credentials",
        "ido": "000"
      })),
    };

    try {
      final response = await _dio.post(loginUrl, data: jsonEncode(body));
      if (response.statusCode == 200) {
        final data = response.data;

        final loginModel = LoginModel.fromJson(data);
        storage.write('login_model', loginModel.toJson());
        storage.write('encryptedUsername', _encrypt(username));
        storage.write('UserName', loginModel.userName);
        print('Login Success: ${data['UserName']}');
        final uri = Uri.parse('http://36.92.75.178:8001');
        final cookies = await DioClient.cookieJar.loadForRequest(uri);
        final sessionCookie = cookies.firstWhere(
          (c) => c.name == 'dtsessionid',
          orElse: () => Cookie('dtsessionid', ''),
        );
        storage.write('session_id', sessionCookie.value);
        print('[COOKIES]${sessionCookie.value}');

        return true;
      } else {
        print('Login failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  Future<bool> checkSession() async {
    try {
      final String path = "/sandbox.ics/v1.0/List/province";
      final headers = signatureController.generateHeaders(
        path: path,
        verb: "GET",
      );
      final response =
          await DioClient.dio.get(path, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return true;
      } else {
        await DioClient.cookieJar.deleteAll();
        return false;
      }
    } catch (e) {
      await DioClient.cookieJar.deleteAll();
      print('Session check error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    await DioClient.cookieJar.deleteAll();
    storage.erase();
    print('Logged out.');
  }
}
