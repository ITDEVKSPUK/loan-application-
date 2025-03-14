import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_apllication/views/Login/models.dart';

class LoginService extends GetxService {
  final Dio _dio = Dio();
  final storage = GetStorage();

  Future<LoggedUser> login(String username, String password) async {
    final url = 'http://36.92.75.178:8001/system/users/logged';

    final headers = {
      "Content-Type": "application/json",
    };

    final body = {
      "username": username,
      "password": password,
    };

    try {
      final response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Capture Set-Cookie header
        final rawCookie = response.headers['set-cookie']?.first;
        if (rawCookie != null) {
          // Extract only the session ID (before ";")
          final sessionId = rawCookie.split(';')[0];
          
          // Store session ID using GetStorage
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
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          final errorData = e.response!.data;
          if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
            throw Exception(errorData['message']);
          }
        }
      }
      throw Exception('Error during login: ${e.toString()}');
    }
  }
}