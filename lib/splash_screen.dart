import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/app_button.dart';
import 'package:loan_apllication/widgets/text_field.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
              labelText: 'Email',
              controller: TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              heigth: 48,
              width: 350),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
              labelText: 'Email',
              controller: TextEditingController(),
              keyboardType: TextInputType.emailAddress,
              heigth: 48,
              width: 350),
          CustomButton(
              text: 'Login',
              onPressed: () {},
              color: AppColors.btnColor,
              borderRadius: 10,
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              paddingVertical: 8,
              paddingHorizontal: 100)
        ],
      ))),
    );
  }
}
