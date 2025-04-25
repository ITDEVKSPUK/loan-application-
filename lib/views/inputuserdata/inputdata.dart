import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/overlayalamat.dart';
import 'package:loan_application/views/inputuserdata/showImageSourcePicker.dart';
import 'package:loan_application/widgets/custom_appbar.dart';
import 'package:loan_application/widgets/textfield_form.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());

  InputData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Form',
        onBack: () {
          Get.offAllNamed('/dashboard');
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto KTP
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => showImageSourcePicker(context, true),
                    child: Obx(() {
                      return Container(
                        width: 317,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: controller.fotoKtp.value != null
                                ? FileImage(controller.fotoKtp.value!)
                                : AssetImage('assets/images/rawktp.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
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

            // NIK dan tombol Cek
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextfieldForm(
                    label: 'NIK',
                    controller: controller.nikController,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () => showLocationBottomSheet(
                        context,
                        (value) => controller.alamatController.text = value,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.casualbutton1,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cek',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            TextfieldForm(
                label: 'Nama Lengkap', controller: controller.namaController),
            TextfieldForm(
                label: 'No. Telpon', controller: controller.telpController),
            TextfieldForm(
                label: 'Pekerjaan', controller: controller.pekerjaanController),
            TextfieldForm(
                label: 'Alamat Lengkap',
                controller: controller.alamatController),

            // Tombol Selengkapnya
            ElevatedButton(
              onPressed: () => showLocationBottomSheet(
                  context, (value) => controller.alamatController.text = value),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.casualbutton1,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Selengkapnya',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.pureWhite,
                    fontFamily: 'Outfit'),
              ),
            ),
            SizedBox(height: 20),

            // Tombol Next di pojok kanan bawah dari area scroll
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                    MyAppRoutes.homeScreen), // ganti sesuai route kamu
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
            SizedBox(height: 30), // biar ga mepet banget ke bawah
          ],
        ),
      ),
    );
  }
}
