import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/navigation/controller/admin/controller_page_admin.dart';
import 'package:loan_apllication/views/admin/History/History_admin.dart';
import 'package:loan_apllication/views/admin/Profile/Profile_admin.dart';
import 'package:loan_apllication/views/admin/Simulation_Calculator/simulation_admin.dart';
import 'package:loan_apllication/views/admin/SuveList/surveylist_admin.dart';

import '../../../core/theme/color.dart';

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

// //BottomNavigationBar(
//           currentIndex: dashboardController.selectedIndex.value,
//           onTap: (index) {
//             dashboardController.selectedIndex.value = index;
//           },
//           selectedItemColor: Colors.blue,
//           unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
//           backgroundColor: Colors.grey[850],
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: "SurveyList",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bookmark),
//               label: "History",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.bookmark),
//               label: "Simulation",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               label: "Profile",
//             ),
//           ],
//         ),
