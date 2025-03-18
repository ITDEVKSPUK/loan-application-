import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/widgets/custom_appbar.dart';

class InputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Input User Data',
        onBack: () {
          Get.offAllNamed('/home'); // Balik ke halaman Home
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
                    height: 200,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/images/rawktp.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 184.67,
                          child: SizedBox(
                            width: 217,
                            height: 15.25,
                            child: Opacity(
                              opacity: 0.53,
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            _buildTextField('NIK'),
            _buildTextField('Nama Lengkap'),
            _buildTextField('No. Telpon'),
            _buildTextField('Pekerjaan'),
            _buildTextField('Alamat Lengkap'),
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
            _buildTextField('Nominal Penjaminan'),
            _buildTextField('Jenis Jaminan'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'TYPE HERE',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
