import 'dart:io';

import 'package:dio/dio.dart' as dio_pkg;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/put_models_update.dart';
import 'package:loan_application/API/service/get_docagun.dart';
import 'package:loan_application/API/service/post_db_survey.dart';
import 'package:loan_application/API/service/post_document.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';
import 'package:loan_application/API/service/put_update_survey.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class CreditFormController extends GetxController {
  final dio_pkg.Dio dio = DioClient.dio;
  final plafondController = TextEditingController();
  final purposeController = TextEditingController();
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
  var selectedAgunanName = ''.obs;
  var selectedDocumentName = ''.obs;
  var selectedKTPImages = <File>[].obs;
  var selectedAgunanImages = <File>[].obs;
  var selectedDocumentImages = <File>[].obs;
  var addDescript = ''.obs;
  var marketValue = ''.obs;

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
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImages.add(image);
      onImagesUpdated();
    }
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
    final picker = ImagePicker();
    final single = await picker.pickImage(source: ImageSource.camera);
    if (single != null) {
      final file = File(single.path);
      final compressed = await compressImage(file);
      selectedKTPImages.add(compressed);
    }
  }

  Future<void> pickAgunanImages(BuildContext context) async {
    final picker = ImagePicker();
    final single = await picker.pickImage(source: ImageSource.camera);
    if (single != null) {
      final file = File(single.path);
      final compressed = await compressImage(file);
      selectedAgunanImages.add(compressed);
    }
  }

  Future<void> pickDocumentImages(BuildContext context) async {
    final picker = ImagePicker();
    final single = await picker.pickImage(source: ImageSource.camera);
    if (single != null) {
      final file = File(single.path);
      final compressed = await compressImage(file);
      selectedDocumentImages.add(compressed);
    }
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
    String cleaned = text.replaceAll(RegExp(r'[^\d]'), '');
    print('cleanNumber: Input: $text, Cleaned: $cleaned');
    if (cleaned.isEmpty) {
      print('cleanNumber: Cleaned string is empty, returning 0.0');
      return 0.0;
    }
    double result = double.tryParse(cleaned) ?? 0.0;
    print('cleanNumber: Parsed result: $result');
    return result;
  }

  Future<void> createSurvey() async {
    try {
      if (cifID.cifId == null) {
        Get.snackbar("Error", "CIF ID is missing");
        print('createSurvey: CIF ID is null');
        return;
      }
      final service = PostSurveyService();
      final plafond = cleanNumber(plafondController.text);
      final income = cleanNumber(incomeController.text);
      final asset = cleanNumber(assetController.text);
      final expenses = cleanNumber(expensesController.text);
      final installment = cleanNumber(installmentController.text);

      print('createSurvey: Sending data - '
          'plafond: $plafond, '
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
          "value": "0",
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
        Get.snackbar(
            "Error", "Unauthorized: Invalid or missing authentication token");
      } else {
        Get.snackbar("Error", "Create survey gagal: ${e.toString()}");
      }
    }
  }

  Future<void> handleSubmit(BuildContext context) async {
    if (selectedAgunanImages.isEmpty ||
        selectedAgunan.value.isEmpty ||
        selectedDocument.value.isEmpty ||
        selectedDocumentImages.isEmpty ||
        addDescript.value.isEmpty ||
        marketValue.value.isEmpty) {
      _showError(context, 'Lengkapi semua input');
      print('handleSubmit: One or more required fields are empty');
      return;
    }

    try {
      if (surveyId != null) {
        print("handleSubmit: Start updating survey with ID: $surveyId");
        print("handleSubmit: selectedAgunan = ${selectedAgunan.value}");
        print("handleSubmit: selectedAgunanName = ${selectedAgunanName.value}");

        print('handleSubmit: Fetching inquiry data for surveyId: $surveyId');
        await fetchInquiryData(surveyId!);
        print('handleSubmit: Inquiry data fetched, proceeding to update');
        await updateSurveyFromInquiry(surveyId!);

        print('handleSubmit: Updating documents...');
        await uploadDocuments();
        print('handleSubmit: Documents uploaded successfully');
        Get.snackbar("Sukses", "Dokumen berhasil diunggah");
        print('handleSubmit: Form submission completed');
        Get.offNamed(MyAppRoutes.dashboard);
      } else {
        _showError(context, 'Gagal membuat survey, upload dibatalkan');
        print('handleSubmit: Survey ID is null, upload cancelled');
      }
    } catch (e) {
      print("❌ Handle submit gagal: $e");
      _showError(context, 'Upload gagal: ${e.toString()}');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool validateForm() {
    bool isValid = [
      plafondController.text,
      purposeController.text,
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

  String? get surveyId =>
      trxSurveyRespons.value.isEmpty ? null : trxSurveyRespons.value;

  final PostInqury postInqury = PostInqury();
  final fetchedInquiryData = Rxn<dynamic>();
  final putUpdateSurvey = PutUpdateSurvey();

  Future<void> fetchInquiryData(String surveyId) async {
    try {
      if (surveyId.isEmpty) {
        Get.snackbar("Error", "Survey ID tidak boleh kosong");
        return;
      }

      final inquiryData = await postInqury.fetchInqury(
        officeId: '000',
        trxSurvey: surveyId,
      );

      if (inquiryData != null) {
        fetchedInquiryData.value = inquiryData;
        print("✅ Inquiry data berhasil diambil: $inquiryData");
      } else {
        Get.snackbar("Error", "Inquiry data kosong atau tidak ditemukan");
      }
    } catch (e) {
      print("❌ Gagal mengambil inquiry data: $e");
      Get.snackbar("Error", "Gagal ambil inquiry data: ${e.toString()}");
    }
  }

  Future<void> updateSurveyFromInquiry(String surveyId) async {
    if (surveyId.isEmpty) {
      Get.snackbar("Error", "Survey ID tidak boleh kosong");
      print("updateSurveyFromInquiry: Survey ID is empty $surveyId");
      return;
    }

    final inquiryData = fetchedInquiryData.value;
    print("updateSurveyFromInquiry: Inquiry data: $inquiryData");
    if (inquiryData == null) {
      Get.snackbar(
          "Error", "Data inquiry belum dimuat, silakan fetch terlebih dahulu");
      return;
    }

    print("🟡 Raw inquiryData: $inquiryData");
    print("🟡 selectedAgunan: ${selectedAgunan.value}");
    print("🟡 selectedAgunanName: ${selectedAgunanName.value}");
    print("🟡 selectedDocument: ${selectedDocument.value}");

    final putModelsUpdate = PutModelsUpdate(
      cifId: int.tryParse(inquiryData.cifId.toString()) ?? 0,
      idLegal: 3319123456,
      officeId: inquiryData.officeId,
      application: Application(
        trxDate: inquiryData.application.trxDate,
        trxSurvey: inquiryData.application.trxSurvey,
        applicationNo: inquiryData.application.applicationNo,
        purpose: inquiryData.application.purpose,
        plafond: inquiryData.application.plafond,
      ),
      collateral: Collateral(
        id: selectedAgunan.value,
        idName: selectedAgunanName.value,
        addDescript: addDescript.value,
        idCatDocument: int.tryParse(selectedDocument.value) ?? 0,
        value: marketValue.value,
      ),
      additionalInfo: AdditionalInfo(
        income: inquiryData.additionalInfo.income.toString(),
        asset: inquiryData.additionalInfo.asset.toString(),
        expenses: inquiryData.additionalInfo.expenses.toString(),
        installment: inquiryData.additionalInfo.installment.toString(),
      ),
    );

    final response = await putUpdateSurvey.putUpdateSurvey(
      surveyId: surveyId,
      surveyData: putModelsUpdate.toJson(),
    );

    print("📦 Payload yang dikirim ke API: ${putModelsUpdate.toJson()}");

    print("updateSurveyFromInquiry: Response: ${response}");
    print("✅ Survey berhasil diperbarui dari inquiry");
    Get.snackbar("Sukses", "Survey berhasil diperbarui");
  }
}
