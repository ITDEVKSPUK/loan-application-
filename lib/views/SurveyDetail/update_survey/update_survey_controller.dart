import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/put_models_update.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';
import 'package:loan_application/API/service/put_update_survey.dart';

class UpdateSurveyController extends GetxController {
  // Text controllers untuk semua field yang dapat diedit
  final purposeController = TextEditingController();
  final plafondController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expenseController = TextEditingController();
  final installmentController = TextEditingController();
  final valueController = TextEditingController();
  final cifIdController = TextEditingController();
  final idLegalController = TextEditingController();
  final officeIdController = TextEditingController();
  final applicationNoController = TextEditingController();
  final trxDateController = TextEditingController();
  final trxSurveyController = TextEditingController();
  final collateralIdController = TextEditingController();
  final collateralNameController = TextEditingController();
  final collateralAddDescController = TextEditingController();
  final collateralCatDocController = TextEditingController();

  final PutUpdateSurvey putUpdateSurvey;
  final PostInqury postInqury = PostInqury();
  final RxBool isLoading = false.obs;
  String surveyId = '';

  UpdateSurveyController({
    required this.putUpdateSurvey,
  });

  /// Format angka ke format Rupiah (contoh: 1000000 -> 1.000.000)
  String formatRupiah(String numberString) {
    if (numberString.isEmpty) return '0';
    final number =
        int.tryParse(numberString.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.');
  }

  /// Menghapus format Rupiah (contoh: 1.000.000 -> 1000000)
  String unformatRupiah(String formatted) {
    return formatted.replaceAll('.', '');
  }

  /// Memuat data survey dari API inquiry
  Future<void> loadSurveyData(dynamic trxSurvey) async {
    isLoading.value = true;
    try {
      final String inquiryTrxSurvey = trxSurvey['trxSurvey']?.toString() ?? '';
      print('Received trxSurvey: $inquiryTrxSurvey');
      if (inquiryTrxSurvey.isEmpty) {
        throw Exception('No valid trxSurvey provided in arguments');
      }

      // Panggil API inquiry
      final inquiryData = await postInqury.fetchInqury(
        officeId: '000',
        trxSurvey: inquiryTrxSurvey,
      );
      print('Inquiry data received: ${inquiryData.toJson()}');

      surveyId = inquiryData.application.trxSurvey ?? '';
      if (surveyId.isEmpty) {
        throw Exception('Invalid or missing surveyId in inquiry response');
      }
      print('Survey ID set: $surveyId');

      cifIdController.text = inquiryData.cifId.toString();
      idLegalController.text = inquiryData.idLegal.toString();
      officeIdController.text = inquiryData.officeId ?? '';
      applicationNoController.text =
          inquiryData.application.applicationNo ?? '';
      trxDateController.text = inquiryData.application.trxDate ?? '';
      trxSurveyController.text = inquiryData.application.trxSurvey ?? '';
      purposeController.text = inquiryData.application.purpose ?? '';
      plafondController.text =
          formatRupiah(inquiryData.application.plafond.toString());
      collateralIdController.text = inquiryData.collateral.id ?? '';
      collateralNameController.text = inquiryData.collateral.idName ?? '';
      collateralAddDescController.text =
          inquiryData.collateral.adddescript ?? '';
      collateralCatDocController.text =
          inquiryData.collateral.idCatDocument.toString();
      valueController.text =
          formatRupiah(inquiryData.collateral.value.toString());
      incomeController.text =
          formatRupiah(inquiryData.additionalInfo.income.toString());
      assetController.text =
          formatRupiah(inquiryData.additionalInfo.asset.toString());
      expenseController.text =
          formatRupiah(inquiryData.additionalInfo.expenses.toString());
      installmentController.text =
          formatRupiah(inquiryData.additionalInfo.installment.toString());
    } catch (e) {
      print('Error loading survey data: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat data survey: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      surveyId = '';
    } finally {
      isLoading.value = false;
    }
  }

  /// Menyimpan data survey ke server
  Future<void> saveSurvey() async {
    try {
      isLoading.value = true;
      print('Attempting to save survey with surveyId: $surveyId');
      if (surveyId.isEmpty || surveyId == 'null') {
        throw Exception('Invalid or missing surveyId');
      }
      if (purposeController.text.isEmpty) {
        throw Exception('Tujuan Pinjaman wajib diisi');
      }
      final putModelsUpdate = PutModelsUpdate(
        cifId: int.tryParse(cifIdController.text) ?? 0,
        idLegal: int.tryParse(idLegalController.text) ?? 0,
        officeId: officeIdController.text,
        application: Application(
          trxDate: trxDateController.text,
          trxSurvey: trxSurveyController.text,
          applicationNo: applicationNoController.text,
          purpose: purposeController.text,
          plafond: int.tryParse(unformatRupiah(plafondController.text)) ?? 0,
        ),
        collateral: Collateral(
          id: collateralIdController.text,
          idName: collateralNameController.text,
          addDescript: collateralAddDescController.text,
          idCatDocument: int.tryParse(collateralCatDocController.text) ?? 0,
          value: int.tryParse(unformatRupiah(valueController.text)) ?? 0,
        ),
        additionalInfo: AdditionalInfo(
          income: int.tryParse(unformatRupiah(incomeController.text)) ?? 0,
          asset: int.tryParse(unformatRupiah(assetController.text)) ?? 0,
          expenses: int.tryParse(unformatRupiah(expenseController.text)) ?? 0,
          installment:
              int.tryParse(unformatRupiah(installmentController.text)) ?? 0,
        ),
      );

      print('Data to be sent: ${jsonEncode(putModelsUpdate.toJson())}');

      // Kirim data ke server
      final response = await putUpdateSurvey.putUpdateSurvey(
        surveyId: surveyId,
        surveyData: putModelsUpdate.toJson(),
      );

      print('API response: $response');

      Get.snackbar(
        'Sukses',
        'Data survey berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back();
    } on DioException catch (e) {
      String errorMessage = 'Failed to update survey';
      if (e.response != null) {
        errorMessage +=
            ': ${e.response?.statusCode} - ${e.response?.data?['message'] ?? 'Unknown error'}';
        print('Dio error details:');
        print('Status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        print('Request URL: ${e.requestOptions.uri}');
        print('Request headers: ${e.requestOptions.headers}');
        print('Request data: ${e.requestOptions.data}');
      } else {
        errorMessage += ': ${e.message}';
      }
      print('Dio error: $errorMessage');
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      print('Unexpected error: $e');
      Get.snackbar(
        'Error',
        'Gagal memperbarui survey: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    purposeController.dispose();
    plafondController.dispose();
    incomeController.dispose();
    assetController.dispose();
    expenseController.dispose();
    installmentController.dispose();
    valueController.dispose();
    cifIdController.dispose();
    idLegalController.dispose();
    officeIdController.dispose();
    applicationNoController.dispose();
    trxDateController.dispose();
    trxSurveyController.dispose();
    collateralIdController.dispose();
    collateralNameController.dispose();
    collateralAddDescController.dispose();
    collateralCatDocController.dispose();
    super.onClose();
  }
}
