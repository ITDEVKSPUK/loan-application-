import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';

class InqurySurveyController extends GetxController {
  var plafond = ''.obs;
  var purpose = ''.obs;
  var adddescript = ''.obs;
  var id_name = ''.obs;
  var value = ''.obs;
  var income = ''.obs;
  var asset = ''.obs;
  var expenses = ''.obs;
  var installment = ''.obs;
  var inquiryModel = Rxn<InquirySurveyModel>();
  var collateralProofs = <CollateralProofModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  /// Format angka ke format Rupiah untuk tampilan (contoh: 1000000 -> Rp1.000.000)
  String formatRupiah(String numberString) {
    if (numberString.isEmpty || numberString == '0' || numberString == '0.00') {
      return 'Rp0';
    }
    final number = double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    if (number == 0) return 'Rp0';
    return 'Rp${number.toInt().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  /// Format angka untuk API dengan dua desimal (contoh: 1000000 -> "1000000.00")
  String formatForApi(String numberString) {
    if (numberString.isEmpty || numberString == '0') return '0.00';
    final number = double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    return number.toStringAsFixed(2);
  }

  void getSurveyList({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );

      inquiryModel.value = inquryResponse;

      // Store values as API-compatible strings with two decimal places
      plafond.value = formatForApi(inquryResponse.application.plafond.toString());
      purpose.value = inquryResponse.application.purpose ?? '';
      id_name.value = inquryResponse.collateral.idName ?? '';
      adddescript.value = inquryResponse.collateral.adddescript ?? '';
      value.value = formatForApi(inquryResponse.collateral.value.toString());
      income.value = formatForApi(inquryResponse.additionalInfo.income.toString());
      asset.value = formatForApi(inquryResponse.additionalInfo.asset.toString());
      expenses.value = formatForApi(inquryResponse.additionalInfo.expenses.toString());
      installment.value = formatForApi(inquryResponse.additionalInfo.installment.toString());

    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: $e';
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}