import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/API/models/history_models.dart';
import 'package:loan_apllication/API/service/post_history.dart';
import 'package:loan_apllication/core/theme/color.dart';

class HomeController extends GetxController {
  var surveyList = <HistoryModel>[].obs;
  var filteredList = <HistoryModel>[].obs;

  void getHistory() async {
    final historyService = HistoryService();

    try {
      final response = await historyService.fetchHistoryDebitur(
        officeId: '000',
        fromDateTime: DateTime.parse('2025-01-01T00:00:00+07:00'),
        toDateTime: DateTime.parse('2025-12-31T00:00:00+07:00'),
      );

      final List<dynamic> rawData = response.data['data'] ?? [];
      surveyList.value = rawData.map((e) => HistoryModel.fromJson(e)).toList();
      filteredList.value = surveyList;
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterSearch(String query) {
    filteredList.value = surveyList
        .where((item) =>
            item.fullName.toLowerCase().contains(query.toLowerCase()) ||
            item.application.purpose
                .toLowerCase()
                .contains(query.toLowerCase()))
        .toList();
  }

  void filterByStatus(String status) {
    filteredList.value =
        surveyList.where((item) => "UNREAD" == status).toList();
  }

  Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'ACCEPTED':
        return AppColors.greenstatus;
      case 'DECLINED':
        return AppColors.redstatus;
      case 'UNREAD':
        return AppColors.orangestatus;
      default:
        return Colors.grey;
    }
  }
}
