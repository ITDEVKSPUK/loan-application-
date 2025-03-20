import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/custom_appbar.dart';
import 'package:loan_apllication/widgets/textfield_form.dart';

class InputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Form',
        onBack: () {
          Get.offAllNamed('/home');
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Tambahkan fungsi untuk memilih gambar di sini
                    },
                    child: Container(
                      width: 317,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/rawktp.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: EdgeInsets.only(left: 6.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'foto ktp (klik untuk mengganti foto)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 90, 137, 255),
                          fontSize: 14,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            TextfieldForm(label: 'NIK'),
            TextfieldForm(label: 'Nama Lengkap'),
            TextfieldForm(label: 'No. Telpon'),
            TextfieldForm(label: 'Pekerjaan'),
            TextfieldForm(label: 'Alamat Lengkap'),
            SizedBox(height: 10),
            TextfieldForm(label: 'Nominal Penjaminan'),
            TextfieldForm(label: 'Jenis Jaminan'),
            SizedBox(height: 20),
            Text(
              'Bukti Jaminan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Tambahkan fungsi untuk memilih gambar di sini
              },
              child: Container(
                width: double.infinity,
                height: 135,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0x7FD9D9D9),
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/upfile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenstatus,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 16, color: AppColors.pureWhite),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.redstatus,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'CLEAR',
                    style: TextStyle(fontSize: 16, color: AppColors.pureWhite),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}