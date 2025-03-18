import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  Container(
                    width: 317,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/rawktp.png'),
                        fit: BoxFit.cover,
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
                          color: Color(0xFF666DFF),
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF666DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text('Selengkapnya',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(height: 10),
            TextfieldForm(label: 'Nominal Penjaminan'),
            TextfieldForm(label: 'Jenis Jaminan'),
          ],
        ),
      ),
    );
  }
}
