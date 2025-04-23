import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/API/service/post_login.dart';

class LoginControllers extends GetxController {
  final LoginService _loginService = LoginService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final storage = GetStorage();

  Future<bool> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = "Username and password cannot be empty.";
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';

    final success = await _loginService.login(username, password);
    isLoading.value = false;

    if (success) {
      Get.offNamed(MyAppRoutes.dashboard);
      return true;
    } else {
      errorMessage.value = "Login failed. Please check your credentials.";
      return false;
    }
  }

  void logout() async {
    await _loginService.logout(); // this clears cookies and storage
    Get.offAllNamed(MyAppRoutes.loginScreen);
  }

  Future<void> autoLoginIfSessionValid() async {
    final isValid = await _loginService.checkSession();
    if (isValid) {
      Get.offNamed(MyAppRoutes.dashboard);
    }
  }

  Future<void> checkSession() async {
    await Future.delayed(const Duration(seconds: 1)); // small splash delay

    final sessionId = storage.read('session_id');
    print('SessionID from storage: $sessionId');

    if (sessionId != null) {
      final sessionValid = await _loginService.checkSession();
      if (sessionValid) {
        Get.offNamed(MyAppRoutes.dashboard);
        return;
      }
    }

    // If session not valid or not found
    Get.offNamed(MyAppRoutes.loginScreen);
  }
}
