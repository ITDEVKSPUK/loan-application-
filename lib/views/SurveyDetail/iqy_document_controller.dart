import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';

class IqyDocumentController extends GetxController {
  var ktpImage = ''.obs; // For KTP (docPerson)
  var img_doc = ''.obs; // For Foto Surat (docAsset)
  var img_agun = ''.obs; // For Foto Tanah (docImg)
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var noteDocument = ''.obs; // To store the note for Document

  // Reference to SurveyController to access collateral data
  final SurveyController surveyController = Get.find<SurveyController>();

  void fetchDocuments({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );

      // Populate image fields
      final documentModel = inquryResponse.document;
      ktpImage.value = documentModel?.docPerson.isNotEmpty ?? false
          ? documentModel!.docPerson[0].img
          : '';
      img_doc.value = documentModel?.docAsset.isNotEmpty ?? false
          ? documentModel!.docAsset[0].img
          : '';
      img_agun.value = documentModel?.docImg.isNotEmpty ?? false
          ? documentModel!.docImg[0].img
          : '';

      // Fetch note for Document from collaboration
      final documentNote = inquryResponse.collaboration.firstWhere(
        (col) => col.content == 'DOC',
        orElse: () => Collaboration(
          approvalNo: '',
          category: '',
          content: '',
          judgment: '',
          date: '',
          note: 'Tidak ada data',
        ),
      ).note;
      noteDocument.value = documentNote;

      // Ensure SurveyController has the latest inquiry data
      surveyController.inquiryModel.value = inquryResponse;
      surveyController.purpose.value = inquryResponse.application.purpose ?? '';
      surveyController.idName.value = inquryResponse.collateral.idName ?? '';
      surveyController.document_type.value =
          inquryResponse.collateral.documentType ?? '';
      surveyController.descript.value = inquryResponse.collateral.addDescript ?? '';
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data dokumen: $e';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Zoom image in full screen
  void showFullScreenImage(String imageUrl) {
    if (imageUrl.isEmpty) return;
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black.withOpacity(0.8),
        body: Stack(
          children: [
            InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(0),
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text(
                      'Gagal memuat gambar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 25,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () => Get.back(),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );
  }
}