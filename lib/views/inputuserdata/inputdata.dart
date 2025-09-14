import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loan_application/API/models/ktp_models.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/History/controller_location.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/views/inputuserdata/ktp_controller.dart';
import 'package:loan_application/views/inputuserdata/overlayalamat.dart';
import 'package:loan_application/widgets/InputUserData/gender_radio.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';
import 'package:loan_application/widgets/InputUserData/upload_ktp.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class InputData extends StatelessWidget {
  final controller = Get.put(InputDataController());
  final locationController = Get.put(LocationController());
  final controllerDoc = Get.find<CreditFormController>();
  final ktpController = Get.put(KtpController());

  final KtpController creditCtrl = Get.find<KtpController>();
  InputData({super.key});

  @override
  Widget build(BuildContext context) {
    controller.addPekerjaanListener();

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
                // Upload KTP
                UploadKTPPicker(controller: controllerDoc),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        final nikFromKtp = ktpController.parsedData.value.nik;
                        if (nikFromKtp != null && nikFromKtp.isNotEmpty) {
                          controller.nikController.text = nikFromKtp;
                        }
                        return Expanded(
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
                        );
                      },
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
                Obx(() {
                  final nikFromKtp = ktpController.parsedData.value.nik;
                  if (nikFromKtp != null && nikFromKtp.isNotEmpty) {
                    controller.nikController.text = nikFromKtp;
                  }
                  return Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TextfieldForm(
                          width: double.infinity,
                          height: 55,
                          label: 'Nama Awal',
                          controller: controller.namaAwalController,
                          readOnly: controller.isNoFirstName.value ||
                              controller.readOnly.value,
                        ),
                        TextfieldForm(
                            width: double.infinity,
                            height: 50,
                            label: 'Nama Akhir',
                            readOnly: controller.isNoLastName.value ||
                                controller.readOnly.value,
                            controller: controller.namaAkhirController),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              value: controller.isNoLastName.value,
                              onChanged: controller.readOnly.value
                                  ? null
                                  : controller.toggleNoLastName,
                            ),
                            const Text(
                              'Tidak Ada Nama Akhir',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Outfit'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Nomor Telepon',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Outfit'),
                            ),
                            const SizedBox(height: 6),
                            Builder(builder: (context) {
                              final isReadOnly = controller.readOnly.value;
                              return IntlPhoneField(
                                initialCountryCode: 'ID',
                                controller: controller.telpController,
                                readOnly: isReadOnly,
                                enabled: !isReadOnly,
                                disableLengthCheck: true,
                                decoration: InputDecoration(
                                  hintText: 'Masukkan Nomor Telepon',
                                  hintStyle: TextStyle(
                                    color: isReadOnly
                                        ? Colors.grey.shade500
                                        : AppColors.black.withOpacity(0.3),
                                    fontSize: 13,
                                    fontFamily: 'Outfit',
                                  ),
                                  filled: true,
                                  fillColor: isReadOnly
                                      ? Colors.grey.shade200
                                      : AppColors.pureWhite.withOpacity(0.05),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: isReadOnly
                                          ? Colors.grey.shade400
                                          : AppColors.black.withOpacity(0.2),
                                      width: 1.2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: isReadOnly
                                          ? Colors.grey.shade400
                                          : AppColors.black.withOpacity(0.2),
                                      width: 1.2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: isReadOnly
                                          ? Colors.grey.shade400
                                          : AppColors.black.withOpacity(0.2),
                                      width: 1.5,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                ),
                                onChanged: (phone) {
                                  controller.selectedCountryCode.value =
                                      phone.countryCode;
                                  controller.telpController.text = phone.number;
                                  print(
                                      'Country Code: ${phone.countryCode}, Phone: ${phone.number}');
                                },
                                invalidNumberMessage:
                                    'Nomor telepon tidak valid',
                              );
                            }),
                          ],
                        ),
                        GenderRadioButtons(
                          gender: controller.selectedGender,
                          isReadOnly: controller.readOnly.value,
                        ),
                        TextfieldForm(
                            width: double.infinity,
                            height: 50,
                            label: 'Kota lahir',
                            readOnly: controller.readOnly.value,
                            controller: controller.kotaAsalController),
                        TextfieldForm(
                            width: double.infinity,
                            height: 50,
                            label: 'Tanggal lahir',
                            controller: controller.tanggallahirController,
                            readOnly: controller.readOnly.value,
                            onTap: controller.readOnly.value
                                ? null
                                : () => controller.pickDate(context),
                            hintText: 'Klik dan Masukan Tanggal Lahir'),
                        // Pekerjaan field with warning below
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextfieldForm(
                              width: double.infinity,
                              height: 50,
                              readOnly: controller.readOnly.value,
                              label: 'Pekerjaan',
                              controller: controller.pekerjaanController,
                              hintText: 'KETIK DISINI',
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(30),
                              ],
                            ),
                            Obx(() => controller.isPekerjaanMax.value
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.warning_amber,
                                          color: AppColors.orangestatus,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Peringatan: Maksimum 30 karakter tercapai',
                                          style: TextStyle(
                                            color: AppColors.orangestatus,
                                            fontSize: 12,
                                            fontFamily: 'Outfit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextfieldForm(
                          width: double.infinity,
                          height: 50,
                          label: 'Nama Pasangan',
                          controller: controller.namaPasanganController,
                          readOnly: controller.isUnmarried.value ||
                              controller.readOnly.value,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(
                              value: controller.isUnmarried.value,
                              onChanged: controller.readOnly.value
                                  ? null
                                  : controller.toggleUnmarried,
                            ),
                            const Text(
                              'Belum Kawin',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Outfit'),
                            ),
                          ],
                        ),
                        TextfieldForm(
                          width: double.infinity,
                          height: 50,
                          label: 'Nik Pasangan',
                          controller: controller.nikpasanganController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          readOnly: controller.isUnmarried.value ||
                              controller.readOnly.value,
                        ),
                        TextfieldForm(
                          width: double.infinity,
                          height: 58,
                          label: 'Domisili',
                          controller: controller.alamatController,
                          readOnly: true,
                          hintText: controller.alamatController.text.isEmpty
                              ? 'Provinsi, Kota, Kecamatan, Desa'
                              : '',
                          onTap: controller.alamatController.text.isEmpty &&
                                  !controller.readOnly.value
                              ? () => showLocationBottomSheet(
                                  context,
                                  (value) =>
                                      controller.alamatController.text = value,
                                  locationController)
                              : null,
                        ),
                        TextfieldForm(
                            width: double.infinity,
                            height: 50,
                            label: 'Detail Alamat',
                            readOnly: controller.readOnly.value,
                            hintText: 'Jalan, RT/RW, Blok, No Rumah',
                            controller: controller.detileAlamatController),
                        TextfieldForm(
                          width: double.infinity,
                          height: 50,
                          label: 'Kode POS',
                          controller: controller.postalCodeController,
                          readOnly: controller.readOnly.value,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),

                        TextfieldForm(
                          width: double.infinity,
                          height: 60,
                          label: 'Titik Kordinat Alamat',
                          controller: controller.mapsUrlController,
                          hintText:
                              controller.selectedLocationLink.value.isEmpty
                                  ? 'Klik untuk memilih lokasi di Google Maps'
                                  : controller.selectedLocationLink.value,
                          readOnly: controller.readOnly.value,
                          onTap: controller.readOnly.value
                              ? null
                              : controller.navigateToGoogleMaps,
                        ),

                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: controller.isNextButtonEnabled.value
                                ? (controller.isDontHaveLoan.value
                                    ? () =>
                                        Get.toNamed(MyAppRoutes.dataPinjaman)
                                    : () => controller.handleNextButton())
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.selanjutnyabutton,
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
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
