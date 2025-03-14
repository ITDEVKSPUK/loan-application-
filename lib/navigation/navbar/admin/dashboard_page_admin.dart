import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/navigation/controller/admin/controller_page_admin.dart';
import 'package:loan_apllication/views/admin/History/History_admin.dart';
import 'package:loan_apllication/views/admin/Profile/Profile_admin.dart';
import 'package:loan_apllication/views/admin/Simulation_Calculator/simulation_admin.dart';
import 'package:loan_apllication/views/admin/SuveList/surveylist_admin.dart';

class DashboardPageAdmin extends StatelessWidget {
  const DashboardPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final ControllerPageAdmin dashboardController =
        Get.put(ControllerPageAdmin());

    final List<Widget> menus = [
      SurveylistAdmin(),
      HistoryAdmin(),
      SimulationAdmin(),
      ProfileAdmin()
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
