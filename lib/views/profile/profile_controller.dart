import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/models/login_models.dart';

class ProfileController extends GetxController {
  final _storage = GetStorage();
  final userName = 'User'.obs;
  final loginName = ''.obs;
  final groupName = ''.obs;
  final legalName = ''.obs;
  final status = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // Coba ambil dari login_model
    final json = _storage.read('login_model');
    if (json != null) {
      try {
        final model = LoginModel.fromJson(json);
        userName.value = model.userName;
        loginName.value = model.loginName;
        groupName.value = model.additionalUser.groupName;
        legalName.value = model.additionalInfo.legalName;
        // status.value = model.status;
        print('Loaded user data from login_model: ${model.userName}');
      } catch (e) {
        print('Error parsing login_model: $e');
        // Fallback jika ada error parsing
        fallbackLoadData();
      }
    } else {
      // Fallback: coba ambil username langsung
      fallbackLoadData();
    }
  }
  
  void fallbackLoadData() {
    final name = _storage.read('UserName');
    if (name != null && name.toString().isNotEmpty) {
      userName.value = name.toString();
      print('Loaded username directly: $name');
    } else {
      print('No user data found in storage');
    }
  }
}