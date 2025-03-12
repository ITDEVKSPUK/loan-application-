import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/app_button.dart';
import 'package:loan_apllication/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: Center(
          child: Container(
              child: Card(
        shape: Border.all(
            color: AppColors.cyanBlue,
            strokeAlign: BorderSide.strokeAlignInside),
        margin: EdgeInsets.all(100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/logo_ksp.png',
                  width: 100, height: 100),
            ),
            SizedBox(height: 12),
            CustomTextField(
                hintStyle: TextStyle(color: AppColors.navyBlue),
                filled: true,
                labelStyle: TextStyle(color: AppColors.navyBlue),
                labelText: 'Username',
                color: const Color.fromARGB(255, 7, 7, 7),
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                heigth: 48,
                width: 350),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                hintStyle: TextStyle(color: AppColors.navyBlue),
                filled: true,
                labelStyle: TextStyle(color: AppColors.pureWhite),
                labelText: 'Password',
                color: const Color.fromARGB(255, 17, 16, 16),
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                heigth: 48,
                width: 350),
            SizedBox(height: 20),
            CustomButton(
                text: 'Login',
                onPressed: () {},
                color: AppColors.royalBlue,
                borderRadius: 10,
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                paddingVertical: 8,
                paddingHorizontal: 100)
          ],
        ),
      ))),
    );
  }
}
