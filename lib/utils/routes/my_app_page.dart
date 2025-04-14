import 'package:get/get.dart';
import 'package:loan_apllication/navigation/navbar/employee/dashboard_page_employee.dart';
import 'package:loan_apllication/splash_screen.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/views/Login/loginScreen.dart';
import 'package:loan_apllication/views/employee/SurveyList/add_from.dart';
import 'package:loan_apllication/views/employee/SurveyList/surveylisy_employee.dart';
import 'package:loan_apllication/views/employee/inputuserdata/inputdata.dart';


class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.dashboard, page: () => DashboardPageEmployee()),
    GetPage(name: MyAppRoutes.homeScreen, page: () => surveyList()),
    GetPage(name: MyAppRoutes.inputDataScreen, page: () => InputData()),
  ];
}
