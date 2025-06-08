import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';

class IqyDocumentController extends GetxController {
  var ktpImage = ''.obs; // For KTP (docPerson)
  var img_doc = ''.obs; // For Foto Tanah (docAsset)
  var img_agun = ''.obs;
  var agunan = ''.obs;
  var asset = ''.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var adddescript = ''.obs;
  var documentModel = Rxn<Document>();

  void fetchDocuments({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );

      // Extract the Document model from the response
      documentModel.value = inquryResponse.document;

      // Populate image fields (assuming one image per category for simplicity)
      ktpImage.value = documentModel.value?.docPerson.isNotEmpty ?? false
          ? documentModel.value!.docPerson[0].img
          : '';
      img_doc.value = documentModel.value?.docAsset.isNotEmpty ?? false
          ? documentModel.value!.docAsset[0].img
          : '';
      img_agun.value = documentModel.value?.docImg.isNotEmpty ?? false
          ? documentModel.value!.docImg[0].img
          : '';

      // Placeholder values for agunan and bpkb (can be updated based on your API response)
      agunan.value = documentModel.value?.docAsset.isNotEmpty ?? false
          ? documentModel.value!.docAsset[0].doc
          : 'Tidak tersedia';
      asset.value = documentModel.value?.docImg.isNotEmpty ?? false
          ? documentModel.value!.docImg[0].doc
          : 'Tidak tersedia';
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data dokumen: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Zoom imgae in full screen yoo
  void showFullScreenImage(String imageUrl) {
    if (imageUrl.isEmpty) return; 
    Get.dialog(
      Scaffold(
        backgroundColor: Colors.black .withOpacity(0.8),
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
                onPressed: () =>
                    Get.back(), // Use Get.back() instead of Navigator
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
