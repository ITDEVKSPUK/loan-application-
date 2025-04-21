import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/API/service/sarvice.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = GetStorage();
  final loginService = LoginService();

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 1)); // small splash delay

    final sessionId = storage.read('session_id');
    print('SessionID from storage: $sessionId');

    if (sessionId != null) {
      final sessionValid = await loginService.checkSession();
      if (sessionValid) {
        Get.offNamed(MyAppRoutes.dashboard);
        return;
      }
    }

    // If session not valid or not found
    Get.offNamed(MyAppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.85),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo_ksp.png',
                  width: 170,
                  height: 170,
                ),
                SizedBox(height: 5),
                Text(
                  'KSP UTAMA KARYA',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Outfit',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
