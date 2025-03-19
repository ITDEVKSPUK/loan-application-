// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';

class Profile_Employe extends StatelessWidget {
  const Profile_Employe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Profile',
            style: TextStyle(
                fontSize: 15,
                color: AppColors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications,
                color: Colors.black), // Ikon Notifikasi
            onPressed: () {
              // Tambahkan aksi jika ikon diklik
              print('Notifikasi ditekan');
            },
          ),
        ],
      ),
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
                Transform.translate(
                  offset: Offset(0, -235), // Tambahkan "const"
                  child: Image.asset('assets/images/logo_ksp.png',
                      width: 120, height: 120),
                ),
                SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(0, -250),
                  child: Text(
                    'Usernya',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontStyle: FontStyle.normal,
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(0, -250),
                  child: Text(
                    'Gmail, nek perlu ngko',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontStyle: FontStyle.normal,
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Transform.translate(
                  offset: const Offset(0, -250),
                  child: Text(
                    'KSP Utama Karya',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontStyle: FontStyle.normal,
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
