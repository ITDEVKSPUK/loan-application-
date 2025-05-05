import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/overlayalamat.dart';
import 'package:loan_application/views/inputuserdata/showImageSourcePicker.dart';
import 'package:loan_application/widgets/custom_appbar.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());

  InputData({super.key});
  DateTime startDate = DateTime.now();
  String selectedDate = '';
  String selectedDateText = '';

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

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextfieldForm(
                    label: 'NIK',
                    controller: controller.nikController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: controller.fetchNikData,
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
                label: 'Nama Awal', controller: controller.namaAwalController),
            TextfieldForm(
                label: 'Nama Akhir',
                controller: controller.namaAkhirController),
            TextfieldForm(
              label: 'No. Telpon',
              controller: controller.telpController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[+\d\s]')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Kelamin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  Obx(() => Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Laki-laki'),
                              leading: Radio<String>(
                                value: 'Laki-laki',
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (controller.selectedGender.value ==
                                        value) {
                                      controller.selectedGender.value = '';
                                      controller.selectedGenderController.text =
                                          '';
                                    } else {
                                      controller.selectedGender.value = value;
                                      controller.selectedGenderController.text =
                                          value;
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text('Perempuan'),
                              leading: Radio<String>(
                                value: 'Perempuan',
                                groupValue: controller.selectedGender.value,
                                onChanged: (value) {
                                  if (value != null) {
                                    if (controller.selectedGender.value ==
                                        value) {
                                      controller.selectedGender.value = '';
                                      controller.selectedGenderController.text =
                                          '';
                                    } else {
                                      controller.selectedGender.value = value;
                                      controller.selectedGenderController.text =
                                          value;
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
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
                      DateFormat('dd-MM-yyyy').format(picked);
                }
              },
              child: AbsorbPointer(
                child: TextfieldForm(
                  label: 'Tanggal Lahir',
                  hintText: 'PILIH TANGGAL LAHIR',
                  controller: controller.tanggallahirController,
                ),
              ),
            ),

            TextfieldForm(
                label: 'Kota lahir', controller: controller.kotaAsalController),
            TextfieldForm(
                label: 'Pekerjaan', controller: controller.pekerjaanController),
            TextfieldForm(
                label: 'Nama Pasangan',
                controller: controller.namaPasanganController),
            TextfieldForm(
              label: 'Nik Pasangan',
              controller: controller.nikpasaganController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[+\d\s]')),
              ],
            ),
            TextfieldForm(
                label: 'Alamat Lengkap',
                controller: controller.alamatController),
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(MyAppRoutes.formAgunan),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.casualbutton1,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
