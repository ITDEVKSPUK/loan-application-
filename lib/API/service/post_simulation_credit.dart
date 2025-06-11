import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/calculator_models.dart';
import 'package:loan_application/utils/signature_utils.dart';

class SimulationService {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/simulation/credit";

  Future<LoanSimulationResponse?> simulateLoan({
    required String method,
    required DateTime loanDate,
    required String interestRate,
    required String loanAmount,
    required String tenor,
    String roundTo = "1", // Default ke "1" seperti di Postman
  }) async {
    try {
      // Format body sama persis seperti di Postman
      final body = {
        "Method": method,
        "LoanDate": loanDate.toUtc().toIso8601String(),
        "InterestRate": double.parse(interestRate).toStringAsFixed(2),
        "LoanAmount": double.parse(loanAmount).toStringAsFixed(2),
        "Tenor": tenor,
        "RoundTo": roundTo,
      };

      print("🔧 Request Body: ${jsonEncode(body)}");

      // Generate headers dengan body yang sudah di-serialize
      final bodyString = jsonEncode(body);
      final headers = signatureController.generateHeaders(
        path: path,
        verb: "POST",
        body: bodyString,
         // Pass body string untuk signature
      );

      print("📡 Headers generated:");
      headers.forEach((key, value) {
        print("  $key: $value");
      });

      print("🚀 Sending request to: ${dio.options.baseUrl}$path");

      final response = await dio.post(
        path,
        data: body, // Kirim sebagai Map, Dio akan serialize otomatis
        options: Options(
          headers: headers,
          validateStatus: (status) {
            return status! < 500; // Accept all status codes < 500
          },
        ),
      );

      print("📥 Response Status: ${response.statusCode}");
      print("📥 Response Headers: ${response.headers}");
      print("📥 Response Data: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return LoanSimulationResponse.fromJson(response.data);
        } else {
          print("❌ Invalid response format: ${response.data.runtimeType}");
          throw Exception(
              'Invalid response format: Expected JSON object, got ${response.data.runtimeType}');
        }
      } else {
        print("❌ HTTP Error: ${response.statusCode}");
        print("❌ Error Data: ${response.data}");
        throw Exception('HTTP ${response.statusCode}: ${response.data}');
      }
    } on DioException catch (e) {
      print('💥 DioException caught:');
      print('  Type: ${e.type}');
      print('  Message: ${e.message}');
      print('  Response Status: ${e.response?.statusCode}');
      print('  Response Data: ${e.response?.data}');
      print('  Request Headers: ${e.requestOptions.headers}');
      print('  Request Data: ${e.requestOptions.data}');

      // Return null instead of throwing exception untuk debugging
      return null;
    } catch (e) {
      print('💥 General Exception: $e');
      return null;
    }
  }
}
