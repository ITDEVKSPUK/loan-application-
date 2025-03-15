import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/navigation/controller/employee/controller_page_employe.dart';
import 'package:loan_apllication/views/employee/History/history_employee.dart';
import 'package:loan_apllication/views/employee/SurveyList/surveylisy_employee.dart';
import 'package:loan_apllication/views/employee/Profile/profile_employee.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/simulation_employee.dart';

class DashboardPageEmployee extends StatelessWidget {
  const DashboardPageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPageEmploye dashboardController =
        Get.put(ControllerPageEmploye());

    final List<Widget> menus = [
      surveyList(),
      History_Employe(),
      Simulation_Employe(),
      Profile_Employe(),
    ];

    return Obx(() {
      return Scaffold(
          body: menus[dashboardController.selectedIndex.value],
          bottomNavigationBar: CurvedNavigationBar(
            index: dashboardController.selectedIndex.value,
            onTap: (index) {
              dashboardController.selectedIndex.value = index;
            },
            items: const [
              CurvedNavigationBarItem(
                child: Icon(
                  Icons.library_books,
                  size: 30,
                ),
                label: 'SurveyList',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.history, size: 30),
                label: 'History',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.calculate, size: 30),
                label: 'Simulation',
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
            color: AppColors.lightBlue,
            buttonBackgroundColor: AppColors.pureWhite,
            backgroundColor: AppColors.pureWhite,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
          ));
    });
  }
}

