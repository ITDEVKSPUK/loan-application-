import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class CheckNik {
  static final signatureController = Get.find<SignatureController>();
  final storage = GetStorage();
  final String path = "/sandbox.ics/v1.0/inquiry-anggota";
  late final String secretKey;
  final dio = DioClient.dio;

  Future<Response> fetchNIK(String nik) async {
    final headers = signatureController.generateHeaders(
      path: path,
      verb: "POST",
    );

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
