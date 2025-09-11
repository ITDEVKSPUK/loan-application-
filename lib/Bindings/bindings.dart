import 'package:get/get.dart';
import 'package:loan_application/utils/signature_utils.dart';
import 'package:loan_application/views/Login/controller.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/views/inputuserdata/ktp_controller.dart';

class MyAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginControllers>(() => LoginControllers(), fenix: true);
    Get.put(SignatureController());
    Get.lazyPut<CreditFormController>(() => CreditFormController(),
        fenix: true);
    Get.lazyPut<KtpController>(() => KtpController(), fenix: true);
  }
}
