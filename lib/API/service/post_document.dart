import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loan_application/API/dio/dio_client.dart';

class DocumentService {
  final dio = DioClient.dio;

  Future<Response> uploadDocuments({
    required File docImageKTP, // doc-008
    required File docImageAgunan, // doc-027
    required File docImageDokumen, // doc-005
    required Map<String, dynamic> requestBody,
    required String timestamp,
  }) async {
    try {
      final formData = FormData();

      // Tambah file KTP
      formData.files.add(MapEntry(
        "doc-008",
        MultipartFile.fromStream(
          docImageKTP.openRead(),
          await docImageKTP.length(),
          filename: "doc-008.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Tambah file Agunan
      formData.files.add(MapEntry(
        "doc-027",
        MultipartFile.fromStream(
          docImageAgunan.openRead(),
          await docImageAgunan.length(),
          filename: "doc-027.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Tambah file Dokumen Agunan
      formData.files.add(MapEntry(
        "doc-005",
        MultipartFile.fromStream(
          docImageDokumen.openRead(),
          await docImageDokumen.length(),
          filename: "doc-005.jpg",
          contentType: MediaType("image", "jpeg"),
        ),
      ));

      // Encode requestbody ke query string
      final encodedRequestBody = Uri.encodeComponent(jsonEncode(requestBody));

      // Kirim request POST
      final response = await dio.post(
        "/sandbox.ics/v1.0/v1/survei/doc-upload?requestbody=$encodedRequestBody",
        data: formData, // ✅ ini dia
        options: Options(
          headers: {
            "ICS-Wipala": "sastra.astana.dwipangga",
            "ICS-Signature": "sandbox.rus2025",
            "ICS-Timestamp": timestamp,
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      return response;
    } catch (e) {
      print("❌ Upload gagal: $e");
      rethrow;
    }
  }
}
