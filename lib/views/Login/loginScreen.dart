
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/utils/routes/my_app_route.dart';
import 'package:loan_apllication/widgets/app_button.dart';
import 'package:loan_apllication/widgets/custom_text.dart';
import 'package:loan_apllication/widgets/text_field.dart';
import 'package:loan_apllication/views/Login/controller.dart'; // Import the controller

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    
    // Use GetX controller with lazy initialization
    final LoginController loginController = Get.find<LoginController>();
    
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Card(
                    color: AppColors.navyBlue.withOpacity(0.10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    margin: EdgeInsets.fromLTRB(30, 50, 30, 100),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 70, 50, 70),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/logo_ksp.png',
                              width: 100, height: 100),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'KSP Utama Karya',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            hintStyle: TextStyle(color: AppColors.pureWhite),
                            filled: true,
                            labelStyle: TextStyle(color: AppColors.blackLight),
                            labelText: 'Username',
                            color: Colors.black12,
                            controller: usernameController,
                            heigth: 45,
                            width: 350,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            hintStyle: TextStyle(color: Colors.white70),
                            filled: true,
                            labelStyle: TextStyle(color: AppColors.blackLight),
                            labelText: 'Password',
                            color: Colors.black12,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            heigth: 45,
                            width: 350,
                          ),
                          SizedBox(height: 10),
                          
                          // Show error message if any
                          Obx(() => loginController.errorMessage.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  loginController.errorMessage.value,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : SizedBox.shrink()
                          ),
                          
                          SizedBox(height: 10),
                          
                          // Show loading indicator or login button
                          Obx(() => loginController.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : CustomButton(
                                text: 'Login',
                                onPressed: () {
                                  loginController.login(
                                    usernameController.text,
                                    passwordController.text,
                                  );
                                },
                                color: AppColors.deepBlue,
                                borderRadius: 8,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                paddingVertical: 10,
                                paddingHorizontal: 60,
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}