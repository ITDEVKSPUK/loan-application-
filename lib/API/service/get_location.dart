import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'http://36.92.75.178:8001/sandbox.ics/v1.0/List';

  static String getToken() {
    final box = GetStorage();
    return box.read("dtsessionid") ?? '';
  }

  static Map<String, String> getHeaders() {
    return {
      'ICS-Wipala': 'sastra.astana.dwipangga',
      'ICS-Timestamp':
          DateTime.now().toUtc().toIso8601String().split('.').first + 'Z',
      'Content-Type': 'application/json',
      "Cookie": getToken(),
    };
  }

  static Future<List<dynamic>> fetchProvinces() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/province'), headers: getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch provinces: ${getToken()}');
      }
    } catch (e) {
      print('Error fetching provinces: $e');
      return [];
    }
  }

  static Future<List<dynamic>> fetchRegencies(String provinceId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Region/$provinceId'),
          headers: getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch regencies: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching regencies: $e');
      return [];
    }
  }

  static Future<List<dynamic>> fetchDistricts(String regencyId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Sector/$regencyId'),
          headers: getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch districts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching districts: $e');
      return [];
    }
  }

  static Future<List<dynamic>> fetchVillages(String districtId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Village/$districtId'),
          headers: getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch villages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching villages: $e');
      return [];
    }
  }
}
