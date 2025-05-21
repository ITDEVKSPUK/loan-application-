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

class CreditFormController extends GetxController {
  final dio_pkg.Dio dio = DioClient.dio;
  final plafondController = TextEditingController();
  final purposeController = TextEditingController();
  final collateralDescriptionController = TextEditingController();
  final collateralValueController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expensesController = TextEditingController();
  final installmentController = TextEditingController();

  final cifID = Get.put(InputDataController());
  // // Selected options
  // String selectedPurpose = 'MODAL KERJA';
  // String selectedCollateralType = 'Mobil';

  // Selected images for the PDF
  List<XFile> selectedImages = [];

  // Agunan and Document data
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
        print(cifID.cifId);
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

  // Picking images (from camera or gallery)
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
                  onImagesUpdated(); // Trigger UI update
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
                onImagesUpdated(); // Trigger UI update
              },
            ),
          ],
        ),
      ),
    );
  }

  // Generate PDF from selected images
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

  // Dispose controllers

  // Convert form data to JSON for submission

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
      final timestamp =
          '${DateTime.now().toUtc().toIso8601String().split('.').first}Z';

      final requestBody = {
        "Office_ID": "000",
        "cif_id": cifID.cifId,
        "application": {"trx_survey": surveyId}
      };
      print('surveyId: $surveyId cifID: ${cifID.cifId}');
      if (selectedDocumentImages.isEmpty ||
          selectedAgunanImages.isEmpty ||
          selectedKTPImages.isEmpty) {
        throw Exception("Gambar KTP, agunan, dan dokumen belum dipilih.");
      }
      print(cifID.cifId);
      print(surveyId);
      Get.snackbar("Uploading", "Harap tunggu...",
          snackPosition: SnackPosition.BOTTOM);

      final DocumentService service = DocumentService();
      final response = await service.uploadDocuments(
        docImageKTP: selectedKTPImages[0],
        docImageAgunan: selectedAgunanImages[0],
        docImageDokumen: selectedDocumentImages[0],
        requestBody: requestBody,
        timestamp: timestamp,
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

  Future<void> createSurvey() async {
    String cleanNumber(String text) => text.replaceAll(RegExp(r'[^0-9]'), '');
    final service = PostSurveyService();
    final response = await service.postSurvey(
      cifId: cifID.cifId ?? 0,
      idLegal: 3319123456,
      officeId: "000",
      application: {
        "trx_date":
            '${DateTime.now().toUtc().toIso8601String().split('.').first}+00:00',
        "application_no": "0",
        "purpose": purposeController.text,
        "plafond": cleanNumber(plafondController.text),
      },
      collateral: {
        "id": "600",
        "id_name": "Mobil",
        "adddescript": "Tanah Bangunan",
        "id_catdocument": 1,
        "document_type": "BPKB",
        "value": 950000000
      },
      additionalInfo: {
        "income": cleanNumber(incomeController.text),
        "asset": cleanNumber(assetController.text),
        "expenses": cleanNumber(expensesController.text),
        "installment": cleanNumber(installmentController.text),
      },
    );
    print(response.data);

    setSurveyId(response.data['trx_idx']);
    print(surveyId);
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (selectedAgunanImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Harap unggah gambar agunan terlebih dahulu.")),
      );
      return;
    }
    try {
      await uploadDocuments(); // Pastikan fungsi ini dipanggil
      Get.snackbar("Sukses", "Dokumen berhasil diunggah");
    } catch (e) {
      Get.snackbar("Error", "Upload gagal: ${e.toString()}");
    }
  }

  bool validateForm() {
    if (plafondController.text.trim().isEmpty ||
        purposeController.text.trim().isEmpty ||
        collateralDescriptionController.text.trim().isEmpty ||
        collateralValueController.text.trim().isEmpty ||
        incomeController.text.trim().isEmpty ||
        assetController.text.trim().isEmpty ||
        expensesController.text.trim().isEmpty ||
        installmentController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  RxString trxSurveyRespons = "".obs;

  void setSurveyId(String data) {
    trxSurveyRespons.value = data;
  }

  String? get surveyId => trxSurveyRespons.value;
}
