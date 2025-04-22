import 'package:get/get.dart';
import 'package:loan_apllication/views/Login/controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllers>(() => LoginControllers(), fenix: true);

  }
}
