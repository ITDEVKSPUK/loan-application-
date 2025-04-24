import 'package:get/get.dart';
import 'package:loan_application/splash_screen.dart';
import 'package:loan_application/utils/navigation/navbar/employee/dashboard_page_employee.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/Login/loginScreen.dart';
import 'package:loan_application/views/home/surveylisy_employee.dart';
import 'package:loan_application/views/inputuserdata/inputdata.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.dashboard, page: () => DashboardPageEmployee()),
    GetPage(name: MyAppRoutes.homeScreen, page: () => SurveyList()),
    GetPage(name: MyAppRoutes.inputDataScreen, page: () => InputData()),
  ];
}
