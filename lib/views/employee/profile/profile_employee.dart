// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/custom_text.dart';

class Profile_Employe extends StatelessWidget {
  const Profile_Employe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          decoration: BoxDecoration(
            // Hapus "const" di sini
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 10, // Seberapa blur shadow-nya
                offset: const Offset(0, -4), // Posisi shadow (ke atas)
              ),
            ],
          ),
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 50, 50, 70),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Transform.translate(
                  offset: Offset(0, -235), // Tambahkan "const"
                  child: Image.asset('assets/images/logo_ksp.png',
                      width: 120, height: 120),
                ),
                SizedBox(height: 5),
                Transform.translate(
                    offset: const Offset(0, -250),
                    child: CustomText(text: 'Usert')),
                SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(0, -250),
                  child: CustomText(
                    text: 'KSP Utama Karya',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
