import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/utils/signature_utils.dart';

class CreateCIFService {
  static final signatureController = Get.find<SignatureController>();
  final dio = DioClient.dio;
  final storage = GetStorage();
  final String path = "/sandbox.ics/v1.0/survei/create-cif";

  Future<Response> createCIF({
    required int idLegal,
    required String officeId,
    required String enikNo,
    required String enikType,
    required String firstName,
    required String lastName,
    required String cityBorn,
    required String pasanganNama,
    required String pasanganIdCart,
    required String region,
    required String sector,
    required String village,
    required String scopeVillage,
    required String addressLine1,
    String? postalCode,
    required String pemberiKerja,
    required String phone,
    required String deskripsiPekerjaan,
    required String mapsUrl,
  }) async {
    try {
      // Generate headers
      final headers = signatureController.generateHeaders(
        path: path,
        verb: "POST",
      );

      // Construct the request body dynamically
      final requestBody = {
        "id_legal": 3319123456,
        "Office_ID": "000",
        "owner": {
          "enik_no": enikNo,
          "enik_type": enikType,
          "firts_name": firstName,
          "last_name": lastName,
          "city_born": cityBorn,
          "pasangan_nama": pasanganNama ?? "",
          "pasangan_idcart": pasanganIdCart ?? "",
        },
        "addres": {
          "region": region,
          "sector": sector,
          "village": village,
          "scope_village": scopeVillage,
          "address_line1": addressLine1,
          "postal_code": postalCode,
          "pemberi_kerja": pemberiKerja,
          "maps_url" : mapsUrl,
          "deskripsi_pekerjaan": deskripsiPekerjaan,
          "phone": phone,
        }
      };

      // Make the POST request
      final response = await dio.post(
        path,
        data: requestBody,
        options: Options(headers: headers),
      );

      // Check for success
      if (response.statusCode == 200) {
        print("CIF created successfully: ${response.data}");
        print(requestBody);
      } else {
        print("Failed to create CIF: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      print("Error creating CIF: $e");
      rethrow;
    }
  }
}
