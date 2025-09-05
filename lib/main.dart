import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/Bindings/bindings.dart';
import 'package:loan_application/utils/routes/my_app_page.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/API/dio/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await GetStorage.init();
  await DioClient.init();
  Get.put(InqurySurveyController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MyAppBinding(),
      initialRoute: MyAppRoutes.splashScreen,
      getPages: MyAppPage.pages,
    );
  }
}
