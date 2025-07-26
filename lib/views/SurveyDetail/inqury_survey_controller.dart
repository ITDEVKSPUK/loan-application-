import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart' as InquiryModels;
import 'package:loan_application/API/models/put_models_update.dart' as UpdateModels;
import 'package:loan_application/API/service/post_inqury_survey.dart';
import 'package:loan_application/API/service/put_update_survey.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';

class SurveyController extends GetxController {
  // Controllers for UpdateSurvey
  final purposeController = TextEditingController();
  final plafondController = TextEditingController();
  final incomeController = TextEditingController();
  final assetController = TextEditingController();
  final expenseController = TextEditingController();
  final installmentController = TextEditingController();
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

  // Observables for DetailSurvey
  final purpose = ''.obs;
  final idName = ''.obs; // For Category Agunan
  final document_type = ''.obs;
  final descript = ''.obs;
  final inquiryModel = Rx<InquiryModels.InquirySurveyModel?>(null);
  final isLoading = false.obs;
  final notePlafond = ''.obs;
  String surveyId = '';

  final PutUpdateSurvey putUpdateSurvey;
  final PostInqury postInqury = PostInqury();

  SurveyController({required this.putUpdateSurvey});

  /// Format angka ke format Rupiah untuk tampilan (contoh: 1000000 -> 1.000.000)
  String formatRupiah(String numberString) {
    if (numberString.isEmpty || numberString == '0' || numberString == '0.00') {
      return '0';
    }

    final number =
        double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    if (number == 0) return '0';

    final isWhole = number == number.roundToDouble();

    final integerPart = number.truncate().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );

    if (isWhole) {
      return integerPart; // Tanpa desimal
    } else {
      // Tambahkan desimal jika bukan .00
      final decimal = number.toStringAsFixed(2).split('.')[1];
      return '$integerPart,$decimal';
    }
  }

  /// Format angka untuk API dengan dua desimal (contoh: 1000000 -> "1000000.00")
  String formatForApi(String numberString) {
    if (numberString.isEmpty || numberString == '0') return '0.00';
    final number =
        double.tryParse(numberString.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
    return number.toStringAsFixed(2);
  }

  /// Menghapus format Rupiah untuk parsing (contoh: 1.000.000 -> 1000000)
  String unformatRupiah(String formatted) {
    if (formatted.isEmpty || formatted == '0') return '0';
    final cleaned = formatted
        .replaceAll(RegExp(r'[^0-9]'), '')
        .replaceFirst(RegExp(r'^0+'), '');
    return cleaned.isEmpty ? '0' : cleaned;
  }

  /// Fetch survey data for DetailSurvey
  Future<void> getSurveyList({required String trxSurvey}) async {
    isLoading.value = true;
    try {
      print('Fetching survey list with trxSurvey: $trxSurvey');
      final inquiryData = await postInqury.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );
      print('Inquiry data received: ${inquiryData.toJson()}');

      inquiryModel.value = inquiryData;
      purpose.value = inquiryData.application.purpose ?? '';
      idName.value = inquiryData.collateral.idName ?? '';
      document_type.value = inquiryData.collateral.documentType ?? '';
      descript.value = inquiryData.collateral.adddescript ?? '';

      // Extract Note for PLAF from Collaboration
      final collaborationList = inquiryData.collaboration;
      notePlafond.value = collaborationList
              .firstWhere(
                (collab) => collab.content == 'PLAF',
                orElse: () => InquiryModels.Collaboration(
                  approvalNo: '',
                  category: '',
                  content: '',
                  judgment: '',
                  date: '',
                  note: 'Tidak ada data',
                ),
              )
              .note;

      print('Category Agunan (idName): ${idName.value}');
      print('Note Plafond: ${notePlafond.value}');
    } catch (e) {
      print('Error fetching survey list: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat data survey: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Load survey data into controllers for UpdateSurvey
  Future<void> loadSurveyData(dynamic trxSurvey) async {
    isLoading.value = true;
    try {
      final String inquiryTrxSurvey = trxSurvey['trxSurvey']?.toString() ?? '';
      print('Received trxSurvey: $inquiryTrxSurvey');
      if (inquiryTrxSurvey.isEmpty) {
        throw Exception('No valid trxSurvey provided in arguments');
      }

      final inquiryData = await postInqury.fetchInqury(
        officeId: '000',
        trxSurvey: inquiryTrxSurvey,
      );

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
      incomeController.text =
          formatRupiah(inquiryData.additionalInfo.income.toString());
      assetController.text =
          formatRupiah(inquiryData.additionalInfo.asset.toString());
      expenseController.text =
          formatRupiah(inquiryData.additionalInfo.expenses.toString());
      installmentController.text =
          formatRupiah(inquiryData.additionalInfo.installment.toString());

      print('Inquiry data received: ${inquiryData.toJson()}');
      // Update observables for DetailSurvey
      inquiryModel.value = inquiryData;
      purpose.value = inquiryData.application.purpose ?? '';
      idName.value = inquiryData.collateral.idName ?? '';
      document_type.value = inquiryData.collateral.adddescript ?? '';
      print('Category Agunan (idName) loaded: ${idName.value}');
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

  /// Save survey data and navigate back to DetailSurvey
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
      if (collateralNameController.text.isEmpty) {
        throw Exception('Category Agunan wajib diisi');
      }

      // Parse and validate numeric fields
      final plafond =
          double.tryParse(unformatRupiah(plafondController.text)) ?? 0.0;
      final income =
          double.tryParse(unformatRupiah(incomeController.text)) ?? 0.0;
      final asset =
          double.tryParse(unformatRupiah(assetController.text)) ?? 0.0;
      final expenses =
          double.tryParse(unformatRupiah(expenseController.text)) ?? 0.0;
      final installment =
          double.tryParse(unformatRupiah(installmentController.text)) ?? 0.0;

      if (plafond <= 0) {
        throw Exception('Plafond harus lebih besar dari 0');
      }

      final putModelsUpdate = UpdateModels.PutModelsUpdate(
        cifId: int.tryParse(cifIdController.text) ?? 0,
        idLegal: int.tryParse(idLegalController.text) ?? 0,
        officeId: officeIdController.text,
        application: UpdateModels.Application(
          trxDate: trxDateController.text,
          trxSurvey: trxSurveyController.text,
          applicationNo: applicationNoController.text,
          purpose: purposeController.text,
          plafond: formatForApi(plafond.toString()),
        ),
        collateral: UpdateModels.Collateral(
          id: collateralIdController.text,
          idName: collateralNameController.text,
          addDescript: collateralAddDescController.text,
          idCatDocument: int.tryParse(collateralCatDocController.text) ?? 0,
          value: '',
        ),
        additionalInfo: UpdateModels.AdditionalInfo(
          income: formatForApi(income.toString()),
          asset: formatForApi(asset.toString()),
          expenses: formatForApi(expenses.toString()),
          installment: formatForApi(installment.toString()),
        ),
      );

      print('Data to be sent: ${jsonEncode(putModelsUpdate.toJson())}');
      print('Collateral idName being sent: ${collateralNameController.text}');

      final response = await putUpdateSurvey.putUpdateSurvey(
        surveyId: surveyId,
        surveyData: putModelsUpdate.toJson(),
      );

      print('API response: $response');

      // Update observables for DetailSurvey
      purpose.value = purposeController.text;
      idName.value = collateralNameController.text;
      document_type.value = collateralAddDescController.text;

      Get.snackbar(
        'Sukses',
        'Data survey berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate back to DetailSurvey and refresh data
      Get.back();
      await getSurveyList(trxSurvey: surveyId);
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

  /// Save survey data and navigate to Form Agunan
  Future<void> saveAndNext() async {
    try {
      isLoading.value = true;
      print('Attempting to save survey with surveyId: $surveyId');
      if (surveyId.isEmpty || surveyId == 'null') {
        throw Exception('Invalid or missing surveyId');
      }
      if (purposeController.text.isEmpty) {
        throw Exception('Tujuan Pinjaman wajib diisi');
      }
      if (collateralNameController.text.isEmpty) {
        throw Exception('Category Agunan wajib diisi');
      }

      // Parse and validate numeric fields
      final plafond =
          double.tryParse(unformatRupiah(plafondController.text)) ?? 0.0;
      final income =
          double.tryParse(unformatRupiah(incomeController.text)) ?? 0.0;
      final asset =
          double.tryParse(unformatRupiah(assetController.text)) ?? 0.0;
      final expenses =
          double.tryParse(unformatRupiah(expenseController.text)) ?? 0.0;
      final installment =
          double.tryParse(unformatRupiah(installmentController.text)) ?? 0.0;

      if (plafond <= 0) {
        throw Exception('Plafond harus lebih besar dari 0');
      }

      final putModelsUpdate = UpdateModels.PutModelsUpdate(
        cifId: int.tryParse(cifIdController.text) ?? 0,
        idLegal: int.tryParse(idLegalController.text) ?? 0,
        officeId: officeIdController.text,
        application: UpdateModels.Application(
          trxDate: trxDateController.text,
          trxSurvey: trxSurveyController.text,
          applicationNo: applicationNoController.text,
          purpose: purposeController.text,
          plafond: formatForApi(plafond.toString()),
        ),
        collateral: UpdateModels.Collateral(
          id: collateralIdController.text,
          idName: collateralNameController.text,
          addDescript: collateralAddDescController.text,
          idCatDocument: int.tryParse(collateralCatDocController.text) ?? 0,
          value: '',
        ),
        additionalInfo: UpdateModels.AdditionalInfo(
          income: formatForApi(income.toString()),
          asset: formatForApi(asset.toString()),
          expenses: formatForApi(expenses.toString()),
          installment: formatForApi(installment.toString()),
        ),
      );

      print('Data to be sent: ${jsonEncode(putModelsUpdate.toJson())}');
      print('Collateral idName being sent: ${collateralNameController.text}');

      final response = await putUpdateSurvey.putUpdateSurvey(
        surveyId: surveyId,
        surveyData: putModelsUpdate.toJson(),
      );

      print('API response: $response');

      // Update observables for DetailSurvey
      purpose.value = purposeController.text;
      idName.value = collateralNameController.text;
      document_type.value = collateralAddDescController.text;

      Get.snackbar(
        'Sukses',
        'Data survey berhasil diperbarui',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to Form Agunan
      Get.toNamed(MyAppRoutes.formAgunan);
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
}