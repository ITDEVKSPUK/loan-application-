import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';

class HomeController extends GetxController {
  var surveyList = [
    {
      'name': 'Azzam Aqila',
      'date': '20th February 2036',
      'location': 'Kudus, Jawa Utara',
      'status': 'ACCEPTED',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Nadira Salsabila',
      'date': '15th March 2036',
      'location': 'Semarang, Jawa Tengah',
      'status': 'DECLINED',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Rizky Fadillah',
      'date': '10th April 2036',
      'location': 'Jakarta, DKI Jakarta',
      'status': 'UNREAD',
      'image': 'assets/images/bg.png',
    },
  ].obs;

  Color getStatusColor(String status) {
    switch (status) {
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
