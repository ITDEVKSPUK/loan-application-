import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/navigation/controller/employee/controller_page_employe.dart';
import 'package:loan_application/views/History/history_employee.dart';
import 'package:loan_application/views/Simulation_Calculator/simulation_employee.dart';
import 'package:loan_application/views/home/surveylisy_employee.dart';
import 'package:loan_application/views/profile/profile_employee.dart';

class DashboardPageEmployee extends StatelessWidget {
  const DashboardPageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPageEmploye dashboardController =
        Get.put(ControllerPageEmploye());

    final List<Widget> menus = [
      SurveyList(),
      HistoryEmployee(),
      Simulation_Employe(),
      ProfileEmployee(),
    ];

    return Obx(() {
      return Scaffold(
          body: menus[dashboardController.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: dashboardController.selectedIndex.value,
              onTap: (index) {
                dashboardController.selectedIndex.value = index;
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.navbar,
              selectedItemColor: AppColors.pureWhite,
              unselectedItemColor: AppColors.pureWhite.withOpacity(0.6),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: 'SurveyList',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calculate),
                  label: 'Simulation',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ]));
    });
  }
}
