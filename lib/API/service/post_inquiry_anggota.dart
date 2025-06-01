import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';
import 'package:loan_application/utils/signature_utils.dart';

class Post_anggota {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final String path = "/sandbox.ics/v1.0/inquiry-anggota";
  Future<InquiryAnggota> fetchInquryanggota({
    required String idLegal,
    required String officeId,
    required String idSearch,
  }) async {
    final headers = signatureController.generateHeaders(
      path: path,
      verb: "POST",
    );

    final body = {
      "id_legal": idLegal,
      "Office_ID": officeId,
      "id_search": {"value": idSearch, "type": "smart"}
    };

    try {
      final response = await dio.post(
        path,
        data: body,
        options: Options(headers: headers),
      );

      print('Response data: ${response.data}');

      return InquiryAnggota.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
        'Failed to fetch history: ${e.response?.data ?? e.message} (${e.response?.statusCode})',
      );
    }
  }
}
