import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/history_models.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';

class InqurySurveyController extends GetxController {
  var plafond = ''.obs;
  var purpose = ''.obs;
  var adddescript = ''.obs;
  var value = ''.obs;
  var income = ''.obs;
  var asset = ''.obs;
  var expenses = ''.obs;
  var installment = ''.obs;
  var inquiryModel = Rxn<InquirySurveyModel>();
  var collateralProofs = <CollateralProofModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  

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
      plafond.value = inquryResponse.application.plafond;
      purpose.value = inquryResponse.application.purpose;
      adddescript.value = inquryResponse.collateral.adddescript;
      value.value = inquryResponse.collateral.value;
      expenses.value = inquryResponse.additionalInfo.expenses;
      income.value = inquryResponse.additionalInfo.income;
      asset.value = inquryResponse.additionalInfo.asset;
      installment.value = inquryResponse.additionalInfo.installment;

      collateralProofs.add(CollateralProofModel(
        date: inquryResponse.application.trxDate.toString(),
        location: inquryResponse.sectorCity,
        type: inquryResponse.collateral.documentType,
        imagePath: 'assets/images/sample.png',
      ));
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}

class CollateralProofModel {
  final String date;
  final String location;
  final String type;
  final String imagePath;
  final String sector_city;

  CollateralProofModel({
    required this.date,
    required this.location,
    required this.type,
    required this.imagePath,
    this.sector_city = '',
  });
}
