import 'package:get/get.dart';
import 'package:loan_application/utils/signature_utils.dart';
import 'package:loan_application/views/Login/controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllers>(() => LoginControllers(), fenix: true);
    Get.put(SignatureController());

  }
}
