import 'dart:io';
import 'package:dio/dio.dart' as dio_pkg;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/service/get_docagun.dart';
import 'package:loan_application/API/service/post_db_survey.dart';
import 'package:loan_application/API/service/post_document.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CreditFormController extends GetxController {
  final dio_pkg.Dio dio = DioClient.dio;
  final plafondController = TextEditingController();
  final purposeController = TextEditingController();
  final collateralValueController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expensesController = TextEditingController();
  final installmentController = TextEditingController();

  final cifID = Get.put(InputDataController());
  List<XFile> selectedImages = [];
  var agunanList = <dynamic>[].obs;
  var documentList = <dynamic>[].obs;
  var selectedAgunan = ''.obs;
  var selectedDocument = ''.obs;
  var selectedKTPImages = <File>[].obs;
  var selectedAgunanImages = <File>[].obs;
  var selectedDocumentImages = <File>[].obs;

  Future<void> fetchAgunan() async {
    try {
      var fetchedAgunan = await getDocAgun.fetchAgunan();
      if (fetchedAgunan.isNotEmpty) {
        agunanList.value = fetchedAgunan;
        print('CIF ID: ${cifID.cifId}');
      }
    } catch (e) {
      print("Error fetching agunan: $e");
    }
  }

  Future<void> fetchDocuments() async {
    try {
      var fetchedDocuments = await getDocAgun.fetchDocuments();
      if (fetchedDocuments.isNotEmpty) {
        documentList.value = fetchedDocuments;
      }
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAgunan();
    fetchDocuments();
  }

  Future<void> pickImagesFromSource(
      BuildContext context, VoidCallback onImagesUpdated) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () async {
                Get.back();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);
                if (image != null) {
                  selectedImages.add(image);
                  onImagesUpdated();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih dari Galeri'),
              onTap: () async {
                Get.back();
                final List<XFile> images = await picker.pickMultiImage();
                selectedImages.addAll(images);
                onImagesUpdated();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<File> generatePdfFromImages() async {
    final pdf = pw.Document();
    for (var image in selectedImages) {
      final imageBytes = await image.readAsBytes();
      final pwImage = pw.MemoryImage(imageBytes);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Image(pwImage),
          ),
        ),
      );
    }

    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/jaminan_bukti.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<File> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 60,
    );

    if (result == null) {
      print("⚠️ Kompresi gagal, mengirim file asli");
      return file;
    } else {
      print("✅ Kompresi berhasil: ${result.length()} bytes");
      print("📁 File disimpan di: ${result.path}");
    }

    return File(result.path);
  }

  Future<void> pickKTPImages(BuildContext context) async {
    final source = await _chooseSource(context);
    if (source == null) return;

    final picker = ImagePicker();

    if (source == ImageSource.gallery) {
      final result = await picker.pickMultiImage();
      if (result.isNotEmpty) {
        for (var e in result) {
          final file = File(e.path);
          final compressed = await compressImage(file);
          selectedKTPImages.add(compressed);
        }
      }
    } else {
      final single = await picker.pickImage(source: source);
      if (single != null) {
        final file = File(single.path);
        final compressed = await compressImage(file);
        selectedKTPImages.add(compressed);
      }
    }
  }

  Future<void> pickAgunanImages(BuildContext context) async {
    final source = await _chooseSource(context);
    if (source == null) return;

    final picker = ImagePicker();

    if (source == ImageSource.gallery) {
      final result = await picker.pickMultiImage();
      if (result.isNotEmpty) {
        for (var e in result) {
          final file = File(e.path);
          final compressed = await compressImage(file);
          selectedAgunanImages.add(compressed);
        }
      }
    } else {
      final single = await picker.pickImage(source: source);
      if (single != null) {
        final file = File(single.path);
        final compressed = await compressImage(file);
        selectedAgunanImages.add(compressed);
      }
    }
  }

  Future<void> pickDocumentImages(BuildContext context) async {
    final source = await _chooseSource(context);
    if (source == null) return;

    final picker = ImagePicker();

    if (source == ImageSource.gallery) {
      final result = await picker.pickMultiImage();
      if (result.isNotEmpty) {
        for (var e in result) {
          final file = File(e.path);
          final compressed = await compressImage(file);
          selectedDocumentImages.add(compressed);
        }
      }
    } else {
      final single = await picker.pickImage(source: source);
      if (single != null) {
        final file = File(single.path);
        final compressed = await compressImage(file);
        selectedDocumentImages.add(compressed);
      }
    }
  }

  Future<ImageSource?> _chooseSource(BuildContext context) async {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Galeri'),
            onTap: () => Get.back(result: ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Kamera'),
            onTap: () => Get.back(result: ImageSource.camera),
          ),
        ],
      ),
    );
  }

  Future<void> uploadDocuments() async {
    try {
      if (cifID.cifId == null || surveyId == null) {
        throw Exception("CIF ID or Survey ID is missing.");
      }
      final requestBody = {
        "Office_ID": "000",
        "cif_id": cifID.cifId,
        "application": {"trx_survey": surveyId}
      };
      print('uploadDocuments: surveyId: $surveyId, cifID: ${cifID.cifId}');
      if (selectedDocumentImages.isEmpty ||
          selectedAgunanImages.isEmpty ||
          selectedKTPImages.isEmpty) {
        throw Exception("Gambar KTP, agunan, dan dokumen belum dipilih.");
      }
      print('uploadDocuments: Request body: $requestBody');
      Get.snackbar("Uploading", "Harap tunggu...",
          snackPosition: SnackPosition.BOTTOM);

      final DocumentService service = DocumentService();
      final response = await service.uploadDocuments(
        docImageKTP: selectedKTPImages[0],
        docImageAgunan: selectedAgunanImages[0],
        docImageDokumen: selectedDocumentImages[0],
        requestBody: requestBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(
            "✅ Upload sukses: ${response.statusCode} ${response.statusMessage}");
        Get.snackbar("Sukses", "Dokumen berhasil diunggah");
      } else {
        print("⚠️ Upload gagal: ${response.statusCode}");
        Get.snackbar(
            "Error", "Upload gagal dengan status: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Upload gagal: $e");
      Get.snackbar("Error", "Upload gagal: ${e.toString()}");
    }
  }

  double cleanNumber(String? text) {
    if (text == null || text.isEmpty) {
      print('cleanNumber: Input is null or empty, returning 0.0');
      return 0.0;
    }
    // Remove all non-digit characters
    String cleaned = text.replaceAll(RegExp(r'[^\d]'), '');
    print('cleanNumber: Input: $text, Cleaned: $cleaned');
    // If the cleaned string is empty, return 0.0
    if (cleaned.isEmpty) {
      print('cleanNumber: Cleaned string is empty, returning 0.0');
      return 0.0;
    }
    // Parse as double
    double result = double.tryParse(cleaned) ?? 0.0;
    print('cleanNumber: Parsed result: $result');
    return result;
  }

  Future<String?> getAuthToken() async {
    // Replace with your actual token retrieval logic
    // Example: Fetch from secure storage or login API
    return 'your_token_here'; // Placeholder: Replace with real token
  }

  Future<void> createSurvey() async {
    try {
      if (cifID.cifId == null) {
        Get.snackbar("Error", "CIF ID is missing");
        print('createSurvey: CIF ID is null');
        return;
      }

      // Fetch auth token
      final token = await getAuthToken();
      if (token == null) {
        Get.snackbar("Error", "Authentication token is missing");
        print('createSurvey: Authentication token is null');
        return;
      }

      // Set token in Dio headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      final service = PostSurveyService();
      final plafond = cleanNumber(plafondController.text);
      final collateralValue = cleanNumber(collateralValueController.text);
      final income = cleanNumber(incomeController.text);
      final asset = cleanNumber(assetController.text);
      final expenses = cleanNumber(expensesController.text);
      final installment = cleanNumber(installmentController.text);

      print('createSurvey: Sending data - '
          'plafond: $plafond, '
          'collateralValue: $collateralValue, '
          'income: $income, '
          'asset: $asset, '
          'expenses: $expenses, '
          'installment: $installment');

      final response = await service.postSurvey(
        cifId: cifID.cifId!,
        idLegal: 3319123456,
        officeId: "000",
        application: {
          "trx_date":
              '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00',
          "application_no": "0",
          "purpose": purposeController.text,
          "plafond": plafond,
        },
        collateral: {
          "id": "600",
          "id_name": "Mobil",
          "adddescript": "Tanah Bangunan",
          "id_catdocument": 1,
          "document_type": "BPKB",
          "value": collateralValue,
        },
        additionalInfo: {
          "income": income,
          "asset": asset,
          "expenses": expenses,
          "installment": installment,
        },
      );
      print('createSurvey: Response data: ${response.data}');

      final trxIdx = response.data['trx_idx']?.toString();
      if (trxIdx == null) {
        Get.snackbar("Error", "Failed to retrieve transaction ID");
        print('createSurvey: Transaction ID (trx_idx) is null');
        return;
      }
      setSurveyId(trxIdx);
      print('createSurvey: Survey ID set to: $surveyId');
    } catch (e) {
      print("❌ Create survey gagal: $e");
      if (e is dio_pkg.DioException && e.response?.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized: Invalid or missing authentication token");
      } else {
        Get.snackbar("Error", "Create survey gagal: ${e.toString()}");
      }
    }
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (!validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi semua kolom formulir.")),
      );
      print('handleSubmit: Form validation failed');
      return;
    }
    if (selectedAgunanImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Harap unggah gambar agunan terlebih dahulu.")),
      );
      print('handleSubmit: No agunan images selected');
      return;
    }
    try {
      await createSurvey();
      if (surveyId != null) {
        await uploadDocuments();
        Get.snackbar("Sukses", "Dokumen berhasil diunggah");
        print('handleSubmit: Documents uploaded successfully');
      } else {
        Get.snackbar("Error", "Gagal membuat survey, upload dibatalkan");
        print('handleSubmit: Survey ID is null, upload cancelled');
      }
    } catch (e) {
      print("❌ Handle submit gagal: $e");
      Get.snackbar("Error", "Upload gagal: ${e.toString()}");
    }
  }

  bool validateForm() {
    bool isValid = [
      plafondController.text,
      purposeController.text,
      collateralValueController.text,
      incomeController.text,
      assetController.text,
      expensesController.text,
      installmentController.text,
    ].every((text) => text != null && text.trim().isNotEmpty);
    print('validateForm: Form is ${isValid ? 'valid' : 'invalid'}');
    return isValid;
  }

  RxString trxSurveyRespons = "".obs;

  void setSurveyId(String data) {
    trxSurveyRespons.value = data;
    print('setSurveyId: Survey ID set to $data');
  }

  String? get surveyId => trxSurveyRespons.value.isEmpty ? null : trxSurveyRespons.value;
}