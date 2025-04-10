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
      HistoryEmployee(),
      Simulation_Employe(),
      Profile_Employe(),
    ];

    return Obx(() {
      return Scaffold(
          body: menus[dashboardController.selectedIndex.value],
          bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.navyBlue,
                  selectedItemColor: AppColors.skyBlue,
                  unselectedItemColor: AppColors.pureWhite,
                  showUnselectedLabels: true,
                  currentIndex: dashboardController.selectedIndex.value,
                  onTap: (index) {
                    dashboardController.selectedIndex.value = index;
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_sharp), label: 'Survey List'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.bookmark), label: 'History'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.calculate), label: 'Simulation'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person), label: 'Profile')
                  ])));
    });
  }
}
