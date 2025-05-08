import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/overlayalamat.dart';
import 'package:loan_application/views/inputuserdata/showImageSourcePicker.dart';
import 'package:loan_application/widgets/InputUserData/gender_radio.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());

  InputData({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Form',
        onBack: () => Get.offAllNamed('/dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
                                : const AssetImage('assets/images/rawktp.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  const Padding(
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
                  const SizedBox(height: 20),
                ],
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'NIK',
                    controller: controller.nikController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: controller.fetchNikData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.casualbutton1,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
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

            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Nama Awal',
                controller: controller.namaAwalController),
            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Nama Akhir',
                controller: controller.namaAkhirController),
            TextfieldForm(
              width: double.infinity,
              height: 50,
              label: 'No. Telpon',
              controller: controller.telpController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[+\d\s]')),
              ],
            ),

            GenderRadioButtons(
              gender: controller.selectedGender,
            ),

            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: controller.startDate.value,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  controller.startDate.value = picked;
                  controller.tanggallahirController.text =
                      DateFormat('yyyy-MM-dd').format(picked);
                }
              },
              child: AbsorbPointer(
                child: TextfieldForm(
                  width: double.infinity,
                  height: 50,
                  label: 'Tanggal Lahir',
                  hintText: 'PILIH TANGGAL LAHIR',
                  controller: controller.tanggallahirController,
                ),
              ),
            ),

            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Kota lahir',
                controller: controller.kotaAsalController),
            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Pekerjaan',
                controller: controller.pekerjaanController),
            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Nama Pasangan',
                controller: controller.namaPasanganController),
            TextfieldForm(
              width: double.infinity,
              height: 50,
              label: 'Nik Pasangan',
              controller: controller.nikpasaganController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[+\d\s]')),
              ],
            ),
            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Detail Alamat',
                controller: controller.detileAlamatController),
            TextfieldForm(
                width: double.infinity,
                height: 50,
                label: 'Alamat Lengkap',
                controller: controller.alamatController),

            ElevatedButton(
              onPressed: () => showLocationBottomSheet(
                  context, (value) => controller.alamatController.text = value),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.casualbutton1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateForm()) {
                    controller.saveForm();
                    Get.toNamed(MyAppRoutes.formAgunan);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please fill all fields correctly.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.casualbutton1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Selanjutnya',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.pureWhite,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}
