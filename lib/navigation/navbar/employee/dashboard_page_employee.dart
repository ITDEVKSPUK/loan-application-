import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/navigation/controller/employee/controller_page_employe.dart';
import 'package:loan_apllication/views/employee/History/history_employee.dart';
import 'package:loan_apllication/views/employee/Home/home.dart';
import 'package:loan_apllication/views/employee/Profile/profile_employee.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/simulation_employee.dart';

class DashboardPageEmployee extends StatelessWidget {
  const DashboardPageEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPageEmploye dashboardController =
        Get.put(ControllerPageEmploye());

    final List<Widget> menus = [
      Home(),
      History_Employe(),
      Simulation_Employe(),
      Profile_Employe(),
    ];

    return Obx(() {
      return Scaffold(
        body: menus[dashboardController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: dashboardController.selectedIndex.value,
          onTap: (index) {
            dashboardController.selectedIndex.value = index;
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Colors.grey[850],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "SurveyList",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: "Simulation",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      );
    });
  }
}
