import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class getlocation {
  static final signatureController = Get.find<SignatureController>();
  static final Dio _dio = DioClient.dio;
  static const path = '/sandbox.ics/v1.0/List';

  static Future<List<dynamic>> fetchProvinces() async {
    try {
      final headers = signatureController.generateHeaders(
        path: '$path/province',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/province',
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
      final headers = signatureController.generateHeaders(
        path: '$path/Region/$provinceId',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/Region/$provinceId',
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
      final headers = signatureController.generateHeaders(
        path: '$path/Sector/$regencyId',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/Sector/$regencyId',
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
      final headers = signatureController.generateHeaders(
        path: '$path/Village/$districtId',
        verb: "GET",
      );
      final response = await _dio.get(
        '$path/Village/$districtId',
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
