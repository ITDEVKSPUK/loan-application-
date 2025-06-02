import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:http_parser/http_parser.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class DocumentService {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;

  Future<Response> uploadDocuments({
    required File docImageKTP,
    required File docImageAgunan,
    required File docImageDokumen,
    required Map<String, dynamic> requestBody,
    required String timestamp,
  }) async {
    try {
      final formData = FormData();
      final ktpLength = await docImageKTP.length();
      final agunanLength = await docImageAgunan.length();
      final dokumenLength = await docImageDokumen.length();

      formData.fields.add(MapEntry(
        "requestbody",
        jsonEncode(requestBody),
      ));
      // Tambah file KTP
      formData.files.add(MapEntry(
        "doc-008",
        await MultipartFile.fromFile(
          docImageKTP.path,
          filename: "doc-008.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Tambah file Agunan
      formData.files.add(MapEntry(
        "doc-027",
        MultipartFile.fromStream(
          () => docImageAgunan.openRead(),
          await docImageAgunan.length(),
          filename: "doc-027.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Tambah file Dokumen Agunan
      formData.files.add(MapEntry(
        "doc-005",
        MultipartFile.fromStream(
          () => docImageDokumen.openRead(),
          await docImageDokumen.length(),
          filename: "doc-005.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Encode requestbody ke query string
      final encodedRequestBody = Uri.encodeComponent(jsonEncode(requestBody));
      final path =
          "/sandbox.ics/v1.0/v1/survei/doc-upload?requestbody=$encodedRequestBody";
      print("✅ doc-008 (KTP): $ktpLength bytes");
      print("✅ doc-027 (Agunan): $agunanLength bytes");
      print("✅ doc-005 (Dokumen): $dokumenLength bytes");
      print("✅ Request Body: $encodedRequestBody");
      print(formData.fields);
      print(formData.files.map((e) => "${e.key}:${e.value.length}"));

      final headers = signatureController.generateHeaders(
        path: path,
        verb: "POST",
      );
      // Kirim request POST
      final response = await dio.post(
        path,
        data: formData,
        options: Options(headers: headers),
      );

      return response;
    } catch (e) {
      print("❌ Upload gagal: $e");
      rethrow;
    }
  }
}
