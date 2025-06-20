import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/History/controller_location.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/overlayalamat.dart';
import 'package:loan_application/widgets/InputUserData/format_phone.dart';
import 'package:loan_application/widgets/InputUserData/gender_radio.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());
  final locationController = Get.put(LocationController());

  InputData({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/dashboard');
        return false;
      },
      child: SafeArea(
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
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'CEK',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.pureWhite,
                                    fontFamily: 'Outfit'),
                              ),
                              const SizedBox(width: 5),
                              const Icon(Icons.check, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Obx(() => TextfieldForm(
                      width: double.infinity,
                      height: 55,
                      label: 'Nama Awal',
                      controller: controller.namaAwalController,
                      readOnly: controller.isNoFirstName.value,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => Checkbox(
                          value: controller.isNoFirstName.value,
                          onChanged: controller.toggleNoFirstName,
                        )),
                    const Text(
                      'Tidak Ada Nama Awal',
                      style: TextStyle(fontSize: 14, fontFamily: 'Outfit'),
                    ),
                  ],
                ),
                TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'Nama Akhir',
                    controller: controller.namaAkhirController),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'No. Telepon',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 6),
                    IntlPhoneField(
                      initialCountryCode: 'ID',
                      disableLengthCheck: false,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: AppColors.black.withOpacity(0.2)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 15),
                      ),
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      onChanged: (phone) {
                        controller.telpController.text =
                            phone.completeNumber; 
                        print(
                            'Phone number updated: ${phone.completeNumber}'); // Debug
                      },
                      invalidNumberMessage: 'Nomor telepon tidak valid',
                      flagsButtonPadding: const EdgeInsets.only(left: 10),
                      dropdownIconPosition: IconPosition.trailing,
                    ),
                  ],
                ),
                GenderRadioButtons(
                  gender: controller.selectedGender,
                ),
                TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'Kota lahir',
                    controller: controller.kotaAsalController),
                TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'Tanggal lahir',
                    controller: controller.tanggallahirController,
                    readOnly: true,
                    onTap: () => controller.pickDate(context),
                    hintText: 'Klik dan Masukan Tanggal Lahir'),
                TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'Pekerjaan',
                    controller: controller.pekerjaanController),
                const SizedBox(height: 10),
                Obx(() => TextfieldForm(
                      width: double.infinity,
                      height: 50,
                      label: 'Nama Pasangan',
                      controller: controller.namaPasanganController,
                      readOnly: controller.isUnmarried.value,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() => Checkbox(
                          value: controller.isUnmarried.value,
                          onChanged: controller.toggleUnmarried,
                        )),
                    const Text(
                      'Belum Kawin',
                      style: TextStyle(fontSize: 14, fontFamily: 'Outfit'),
                    ),
                  ],
                ),
                Obx(() => TextfieldForm(
                      width: double.infinity,
                      height: 50,
                      label: 'Nik Pasangan',
                      controller: controller.nikpasanganController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      readOnly: controller.isUnmarried.value,
                    )),
                TextfieldForm(
                  width: double.infinity,
                  height: 60,
                  label: 'Titik Kordinat Alamat',
                  controller: controller.mapsUrlController,
                  hintText: controller.selectedLocationLink.value.isEmpty
                      ? 'Klik untuk memilih lokasi di Google Maps'
                      : controller.selectedLocationLink.value,
                  readOnly: true,
                  onTap: controller.navigateToGoogleMaps,
                ),
                TextfieldForm(
                  width: double.infinity,
                  height: 50,
                  label: 'Kode POS',
                  controller: controller.postalCodeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                TextfieldForm(
                    width: double.infinity,
                    height: 50,
                    label: 'Detail Alamat',
                    hintText: 'Jalan, RT/RW, Blok, No Rumah',
                    controller: controller.detileAlamatController),
                const SizedBox(height: 10),
                TextfieldForm(
                  width: double.infinity,
                  height: 58,
                  label: 'Alamat',
                  controller: controller.alamatController,
                  readOnly: true,
                  hintText: controller.alamatController.text.isEmpty
                      ? 'Provinsi, Kota, Kecamatan, Desa'
                      : '',
                ),
                ElevatedButton(
                  onPressed: () => showLocationBottomSheet(
                      context,
                      (value) => controller.alamatController.text = value,
                      locationController),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.casualbutton1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        'Selengkapnya',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.pureWhite,
                            fontFamily: 'Outfit'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.isNextButtonEnabled.value
                            ? () => controller.handleNextButton()
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isNextButtonEnabled.value
                              ? AppColors.selanjutnyabutton
                              : Colors.grey,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Selanjutnya',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.pureWhite,
                                  fontFamily: 'Outfit'),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_outlined,
                                color: Colors.white),
                          ],
                        ),
                      )),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
