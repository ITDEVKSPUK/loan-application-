// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/app_button.dart';
import 'package:loan_apllication/widgets/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bckrnd.png"),
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
                              fontFamily: 'OutfitRegular',
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
                          controller: TextEditingController(),
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
                          controller: TextEditingController(),
                          keyboardType: TextInputType.text,
                          obscureText: true, // Aktifkan fitur hide/show
                          heigth: 45,
                          width: 350,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                          text: 'Login',
                          onPressed: () {},
                          color: AppColors.deepBlue,
                          borderRadius: 8,
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          paddingVertical: 10,
                          paddingHorizontal: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
