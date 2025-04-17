import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/inputuserdata/formcontroller.dart';
import 'package:loan_apllication/views/employee/inputuserdata/overlayalamat.dart';
import 'package:loan_apllication/widgets/custom_appbar.dart';
import 'package:loan_apllication/widgets/textfield_form.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());

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
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: controller.pickImageKtp,
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
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Cek',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),


            TextfieldForm(label: 'Nama Lengkap', controller: controller.namaController),
            TextfieldForm(label: 'No. Telpon', controller: controller.telpController),
            TextfieldForm(label: 'Pekerjaan', controller: controller.pekerjaanController),
            TextfieldForm(label: 'Alamat Lengkap', controller: controller.alamatController),
            //button alamat
            ElevatedButton(
                  onPressed: () => showLocationBottomSheet(context, (value) => controller.alamatController.text = value),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.casualbutton1,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Selengkapnya',
                    style: TextStyle(fontSize: 16, color: AppColors.pureWhite, fontFamily: 'Outfit'),
                  ),
                ),
            SizedBox(height: 10),
            TextfieldForm(label: 'Nominal Penjaminan', controller: controller.nominalController),
            TextfieldForm(label: 'Jenis Jaminan', controller: controller.jenisJaminanController),
            SizedBox(height: 20),
            Text(
              'Bukti Jaminan',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: controller.pickImageJaminan,
              child: Obx(() {
                return Container(
                  width: double.infinity,
                  height: 135,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0x7FD9D9D9),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: controller.buktiJaminan.value != null
                          ? FileImage(controller.buktiJaminan.value!)
                          : AssetImage('assets/images/upfile.png') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.saveForm,
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
                  onPressed: controller.clearForm,
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