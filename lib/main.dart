import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/Bindings/bindings.dart';
import 'package:loan_apllication/utils/routes/my_app_page.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
