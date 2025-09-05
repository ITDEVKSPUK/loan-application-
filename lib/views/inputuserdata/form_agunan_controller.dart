import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart' as dio_pkg;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/dio/dio_client.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart'
    hide Collateral, Application, AdditionalInfo;
import 'package:loan_application/API/models/put_models_update.dart';
import 'package:loan_application/API/service/get_docagun.dart';
import 'package:loan_application/API/service/post_db_survey.dart';
import 'package:loan_application/API/service/post_document.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';
import 'package:loan_application/API/service/put_update_survey.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/kamera_screen.dart';
import 'package:loan_application/widgets/InputUserData/ktp_preview.dart';
import 'package:path_provider/path_provider.dart';

class CreditFormController extends GetxController {
  final dio_pkg.Dio dio = DioClient.dio;
  final plafondController = TextEditingController();
  final purposeController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expensesController = TextEditingController();
  final installmentController = TextEditingController();
  final addDescript = TextEditingController();
  final marketValue = TextEditingController();
  final selectedAgunanName = TextEditingController();
  final selectedDocumentName = TextEditingController();

  final cifID = Get.put(InputDataController());
  List<XFile> selectedImages = [];
  var agunanList = <dynamic>[].obs;
  var documentList = <dynamic>[].obs;
  var documentModel = Rxn<Document>();
  var collacteral = Rxn<Collateral>();
  var ktpImage = ''.obs;
  var img_doc = ''.obs;
  var img_agun = ''.obs;
  var selectedAgunan = ''.obs;
  var selectedDocument = ''.obs;
  var selectedKTPImages = <File>[].obs;
  var selectedAgunanImages = <File>[].obs;
  var selectedDocumentImages = <File>[].obs;

  // Camera-related variables
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  var isCameraInitialized = false.obs;
  var cameraPreview = Rx<Widget>(Container());
  var isProcessing = false.obs;

  // Method untuk mencari ID berdasarkan nama/deskripsi
  void setAgunanIdByName(String agunanName) {
    if (agunanName.isEmpty || agunanList.isEmpty) return;

    try {
      final agunan = agunanList.firstWhere(
        (item) =>
            item['descript'].toString().toLowerCase().trim() ==
            agunanName.toLowerCase().trim(),
      );
      selectedAgunan.value = agunan['ida'].toString();
      print(
          '✅ Agunan ID berhasil di-set: ${selectedAgunan.value} untuk nama: $agunanName');
    } catch (e) {
      print('⚠️ Agunan dengan nama "$agunanName" tidak ditemukan');
      selectedAgunan.value = '';
    }
  }

  void setDocumentIdByName(String documentName) {
    if (documentName.isEmpty || documentList.isEmpty) return;

    try {
      final document = documentList.firstWhere(
        (item) =>
            item['name'].toString().toLowerCase().trim() ==
            documentName.toLowerCase().trim(),
      );
      selectedDocument.value = document['id_catdocument'].toString();
      print(
          '✅ Document ID berhasil di-set: ${selectedDocument.value} untuk nama: $documentName');
    } catch (e) {
      print('⚠️ Document dengan nama "$documentName" tidak ditemukan');
      selectedDocument.value = '';
    }
  }

  void syncAllIdsWithCurrentText() {
    // Sync Agunan ID
    if (selectedAgunanName.text.isNotEmpty) {
      setAgunanIdByName(selectedAgunanName.text);
    }

    // Sync Document ID
    if (selectedDocumentName.text.isNotEmpty) {
      setDocumentIdByName(selectedDocumentName.text);
    }
  }

  Future<void> fetchCategory() async {
    try {
      var fetchedAgunan = await getDocAgun.fetchAgunan();
      var fetchedDocuments = await getDocAgun.fetchDocuments();

      if (fetchedAgunan.isNotEmpty) {
        agunanList.value = fetchedAgunan;
        print('CIF ID: ${cifID.cifId}');

        // ✅ Sync ID setelah data agunan dimuat
        if (selectedAgunanName.text.isNotEmpty) {
          setAgunanIdByName(selectedAgunanName.text);
        }
      }

      if (fetchedDocuments.isNotEmpty) {
        documentList.value = fetchedDocuments;

        // ✅ Sync ID setelah data dokumen dimuat
        if (selectedDocumentName.text.isNotEmpty) {
          setDocumentIdByName(selectedDocumentName.text);
        }
      }
    } catch (e) {
      print("Error fetching agunan: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
    setupAutoSync();
  }

  Future<void> fetchDocuments() async {
    final inquryService = PostInqury();

    try {
      var inquiryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: surveyId ?? '',
      );

      // Extract the Document model from the response
      documentModel.value = inquiryResponse.document;
      addDescript.text = inquiryResponse.collateral.addDescript ?? '';
      marketValue.text = inquiryResponse.collateral.value ?? '0';
      selectedAgunanName.text = inquiryResponse.collateral.idName ?? '';
      selectedDocumentName.text = inquiryResponse.collateral.documentType ?? '';

      // ✅ Set ID setelah text di-set
      if (selectedAgunanName.text.isNotEmpty) {
        setAgunanIdByName(selectedAgunanName.text);
      }
      if (selectedDocumentName.text.isNotEmpty) {
        setDocumentIdByName(selectedDocumentName.text);
      }

      ktpImage.value = documentModel.value?.docPerson.isNotEmpty ?? false
          ? documentModel.value!.docPerson[0].img
          : '';
      img_doc.value = documentModel.value?.docAsset.isNotEmpty ?? false
          ? documentModel.value!.docAsset[0].img
          : '';
      img_agun.value = documentModel.value?.docImg.isNotEmpty ?? false
          ? documentModel.value!.docImg[0].img
          : '';
      print("📄 Document model fetched: ${documentModel.value}");

      final dio = Dio();
      final tempDir = await getTemporaryDirectory();

      if (ktpImage.value.isNotEmpty) {
        final url = ktpImage.value;
        final filePath = "${tempDir.path}/${url.split('/').last}";
        print("📥 Downloading KTP image from: $url to $filePath");
        await dio.download(url, filePath);
        final file = File(filePath);
        final compressed = await compressImage(file);
        selectedKTPImages.add(compressed);
      }

      if (img_doc.value.isNotEmpty) {
        final url = img_doc.value;
        final filePath = "${tempDir.path}/${url.split('/').last}";
        await dio.download(url, filePath);
        final file = File(filePath);
        final compressed = await compressImage(file);
        selectedDocumentImages.add(compressed);
      }

      if (img_agun.value.isNotEmpty) {
        final url = img_agun.value;
        final filePath = "${tempDir.path}/${url.split('/').last}";
        await dio.download(url, filePath);
        final file = File(filePath);
        final compressed = await compressImage(file);
        selectedAgunanImages.add(compressed);
      }
    } catch (e) {
      print("Error fetching documents: $e");
    }
  }

  // Method untuk set agunan yang dipilih (untuk dropdown)
  void setSelectedAgunan(Map<String, dynamic> agunan) {
    selectedAgunan.value = agunan['ida'].toString();
    selectedAgunanName.text = agunan['descript'];
    print(
        '✅ Manual selection - Agunan ID: ${selectedAgunan.value}, Name: ${selectedAgunanName.text}');
  }

  void setSelectedDocument(Map<String, dynamic> document) {
    selectedDocument.value = document['id_catdocument'].toString();
    selectedDocumentName.text = document['name'];
    print(
        '✅ Manual selection - Document ID: ${selectedDocument.value}, Name: ${selectedDocumentName.text}');
  }

  Future<File> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 70,
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
    Get.to(() => KtpCameraScreen(controller: this));
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
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          title: 'Sukses',
          desc: 'Dokumen berhasil diunggah',
          btnOkOnPress: () {},
          btnOkColor: Colors.green,
        ).show();
      } else {
        print("⚠️ Upload gagal: ${response.statusCode}");
        _showError(
            Get.context!, "Upload gagal dengan status: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Upload gagal: $e");
      _showError(Get.context!, 'Upload gagal: ${e.toString()}');
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
        addDescript.text.isEmpty ||
        marketValue.text.isEmpty) {
      _showError(context, 'Lengkapi semua input');
      print('handleSubmit: One or more required fields are empty');
      return;
    }

    try {
      if (surveyId != null) {
        await fetchInquiryData(surveyId!);
        await updateSurveyFromInquiry(surveyId!);
        await uploadDocuments();
        print('handleSubmit: Documents uploaded successfully');
        print('handleSubmit: Form submission completed');
        Get.offAllNamed(MyAppRoutes.dashboard);
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
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: 'Error',
      desc: message,
      btnOkOnPress: () {},
      btnOkColor: Colors.red,
    ).show();
  }

  bool validateForm() {
    bool isValid = [
      plafondController.text,
      purposeController.text,
      incomeController.text,
      assetController.text,
      expensesController.text,
      installmentController.text,
    ].every((text) => text.trim().isNotEmpty);
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

      fetchedInquiryData.value = inquiryData;
      print("✅ Inquiry data berhasil diambil: $inquiryData");
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
    print("🟡 marketValue: ${marketValue.value}");

    // Clean marketValue to ensure it's a valid floating-point number
    final cleanedMarketValue = cleanNumber(marketValue.text).toStringAsFixed(2);

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
        idName: selectedAgunanName.text,
        addDescript: addDescript.text,
        idCatDocument: int.tryParse(selectedDocument.value) ?? 0,
        value: cleanedMarketValue, // Use cleaned market value
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

  Future<void> scanKTP(BuildContext context) async {
    if (isProcessing.value) return;
    isProcessing.value = true;

    try {
      await _initializeControllerFuture;
      final image = await _cameraController.takePicture();
      final compressedFile = await compressImage(File(image.path));
      Get.to(() => KtpPreviewScreen(
            imageFile: compressedFile,
            onConfirm: () {
              selectedKTPImages.add(compressedFile);

              // Kembali 2x: dari preview -> kamera -> halaman sebelum kamera
              Get.back(); // keluar dari preview
              Get.back(); // keluar dari kamera
              Get.snackbar('Sukses', 'Foto KTP berhasil disimpan');
            },
          ));
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil foto: $e');
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> initializeCamera() async {
    try {
      print('initializeCamera: Memulai inisialisasi kamera');
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw Exception("Tidak ada kamera yang tersedia");
      }

      final firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      _initializeControllerFuture = _cameraController.initialize();
      await _initializeControllerFuture;

      // ✅ Matikan flash di sini
      await _cameraController.setFocusMode(FocusMode.auto);
      await _cameraController.setFlashMode(FlashMode.off); // ⬅️ Matikan flash

      cameraPreview.value = CameraPreview(_cameraController);
      isCameraInitialized.value = true;
      print('initializeCamera: Kamera berhasil diinisialisasi');
    } catch (e) {
      print("❌ initializeCamera: Error inisialisasi kamera: $e");
      isCameraInitialized.value = false;
      Get.snackbar(
        "Error",
        "Gagal menginisialisasi kamera: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void setupAutoSync() {
    // Listener untuk agunanList
    ever(agunanList, (_) {
      if (selectedAgunanName.text.isNotEmpty) {
        setAgunanIdByName(selectedAgunanName.text);
      }
    });

    // Listener untuk documentList
    ever(documentList, (_) {
      if (selectedDocumentName.text.isNotEmpty) {
        setDocumentIdByName(selectedDocumentName.text);
      }
    });
  }

  void disposeCamera() {
    print('disposeCamera: Membuang kamera');
    _cameraController.dispose();
    isCameraInitialized.value = false;
  }
}
