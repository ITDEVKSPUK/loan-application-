import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/API/models/history_models.dart';
import 'package:loan_application/API/service/post_history.dart';
import 'package:loan_application/core/theme/color.dart';

class HomeController extends GetxController {
  var surveyList = <Datum>[].obs;
  var filteredList = <Datum>[].obs;

  void getHistory() async {
    final historyService = HistoryService();

    try {
      final response = await historyService.fetchHistoryDebitur(
        officeId: '000',
        fromDateTime: DateTime.parse('2025-01-01T00:00:00+07:00'),
        toDateTime: DateTime.parse('2025-12-31T00:00:00+07:00'),
      );

      print(response.data);
      // Parse the response into a HistoryResponse object
      final historyResponse = HistoryResponse.fromJson(response.data);

      // Assign the parsed data to surveyList and filteredList
      surveyList.value = historyResponse.data;
      filteredList.value = historyResponse.data;

      if (surveyList.isEmpty) {
        debugPrint('No data found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterSearch(String query) {
    filteredList.value = surveyList.where((item) {
      final queryLower = query.toLowerCase();
      final fullName = item.fullName.toLowerCase();
      final purpose = item.application.purpose.toLowerCase();
      final trx_survey = item.application.trxSurvey.toString().toLowerCase();
      final aged = item.aged.toString().toLowerCase();
      final date = DateFormat('yyyy-MM-dd')
          .format(item.application.trxDate)
          .toLowerCase();

      return fullName.contains(queryLower) ||
          purpose.contains(queryLower) ||
          trx_survey.contains(queryLower) ||
          aged.contains(queryLower) ||
          date.contains(queryLower);
    }).toList();
  }

  void filterByStatus(String status) {
    print('FILTER BY STATUS: $status');

    filteredList.value = surveyList.where((item) {
      final statusText = item.status?.value ?? item.application.toString();
      print('Actual item status: ${statusText.toUpperCase()}');

      return status.toUpperCase() == 'ALL'
          ? true
          : statusText.toUpperCase() == status.toUpperCase();
    }).toList();
  }

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return AppColors.greenstatus;
      case 'DECLINED':
        return AppColors.redstatus;
      case 'PROGRESS':
        return AppColors.orangestatus;
      default:
        return Colors.grey;
    }
  }
}
