import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/views/Login/models.dart';
import 'package:loan_apllication/views/Login/sarvice.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  Rx<LoggedUser?> loggedUser = Rx<LoggedUser?>(null);

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = "Username and password cannot be empty";
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final userData = await _loginService.login(username, password);
      loggedUser.value = userData;
      isLoading.value = false;

      // Navigate to the home screen or dashboard
      Get.toNamed(MyAppRoutes.homeScreen);
      return true;
    } catch (e) {
      errorMessage.value =
          "Login failed: ${e.toString().split('Exception: ').last}";
      isLoading.value = false;
      return false;
    }
  }

  void logout() {
  loggedUser.value = null;
  final storage = GetStorage();
  storage.remove('dtsessionid'); // Remove the session ID
  Get.offAllNamed('/login');
}
}
