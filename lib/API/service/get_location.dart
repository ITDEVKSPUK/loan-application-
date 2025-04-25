import 'package:dio/dio.dart';
import 'package:loan_application/API/dio/dio_client.dart';

class getlocation {
  static final Dio _dio = DioClient.dio;
  static const baseUrl = '/sandbox.ics/v1.0/List';

  static final headers = {
    'ICS-Wipala': 'sastra.astana.dwipangga',
    'ICS-Timestamp':
        '${DateTime.now().toUtc().toIso8601String().split('.').first}Z',
  };

  static Future<List<dynamic>> fetchProvinces() async {
    try {
      final response = await _dio.get(
        '$baseUrl/province',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to fetch provinces: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching provinces: $e');
      return [];
    }
  }

  static Future<List<dynamic>> fetchRegencies(String provinceId) async {
    try {
      final response = await _dio.get(
        '$baseUrl/Region/$provinceId',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
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
      final response = await _dio.get(
        '$baseUrl/Sector/$regencyId',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
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
      final response = await _dio.get(
        '$baseUrl/Village/$districtId',
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Failed to fetch villages: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching villages: $e');
      return [];
    }
  }
}
