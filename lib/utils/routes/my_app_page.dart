import 'package:get/get.dart';
import 'package:loan_apllication/navigation/navbar/admin/dashboard_page_admin.dart';
import 'package:loan_apllication/navigation/navbar/employee/dashboard_page_employee.dart';
import 'package:loan_apllication/splash_screen.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/views/Login/loginScreen.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.dashboard, page: () => DashboardPageAdmin()),
  ];
}
