import 'package:get/get.dart';
import 'package:loan_application/splash_screen.dart';
import 'package:loan_application/utils/navigation/navbar/employee/dashboard_page_employee.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/Login/loginScreen.dart';
import 'package:loan_application/views/SurveyDetail/detail_anggota.dart';
import 'package:loan_application/views/SurveyDetail/detail_document.dart';
import 'package:loan_application/views/SurveyDetail/detail_survey.dart';
import 'package:loan_application/views/SurveyDetail/update_survey/update_suevey.dart';
import 'package:loan_application/views/home/surveylisy_employee.dart';
import 'package:loan_application/views/inputuserdata/inputdata.dart';
import 'package:loan_application/views/inputuserdata/lampiran_agunan.dart';

class MyAppPage {
  static final List<GetPage> pages = [
    //GetPage(name: name, page: page)
    GetPage(name: MyAppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyAppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyAppRoutes.dashboard, page: () => DashboardPageEmployee()),
    GetPage(name: MyAppRoutes.homeScreen, page: () => SurveyList()),
    GetPage(name: MyAppRoutes.inputDataScreen, page: () => InputData()),
    GetPage(name: MyAppRoutes.formAgunan, page: () => FullCreditFormPage()),
    GetPage(name: MyAppRoutes.detailanggota, page: () => DatailAnggota()),
    GetPage(name: MyAppRoutes.detaildocumen, page: () => DetailDocument()),
    GetPage(name: MyAppRoutes.updateSurvey, page: () => UpdateSuevey()),
    GetPage(name: MyAppRoutes.detailsurvey, page: () => DetailSurvey())
  ];
}
