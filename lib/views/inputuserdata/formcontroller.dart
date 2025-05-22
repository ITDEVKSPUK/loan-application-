import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/API/models/anggota_models.dart';
import 'package:loan_application/API/models/cif_models.dart';
import 'package:loan_application/API/service/post_create_CIF.dart';
import 'package:loan_application/API/service/post_nik_check.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';

class InputDataController extends GetxController {
  final nikController = TextEditingController();
  final selectedGenderController = TextEditingController();
  final nikpasaganController = TextEditingController();
  final namaAwalController = TextEditingController();
  final namaAkhirController = TextEditingController();
  final namaPasanganController = TextEditingController();
  final tanggallahirController = TextEditingController();
  final kotaAsalController = TextEditingController();
  final telpController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final alamatController = TextEditingController();
  final nominalController = TextEditingController();
  final jenisJaminanController = TextEditingController();
  final detileAlamatController = TextEditingController();
  final postalCodeController = TextEditingController();

  Rx<File?> fotoKtp = Rx<File?>(null);
  Rx<File?> buktiJaminan = Rx<File?>(null);
  RxString selectedGender = ''.obs;
  final Rx<DateTime> startDate = DateTime.now().obs;
  final RxString selectedDateText = ''.obs;
  final RxString selectedDate = ''.obs;

  final ImagePicker _picker = ImagePicker();

  get pickImageJaminan => null;

  Future<bool> checkNik() async {
    final checkNikService = CheckNik();

    try {
      final response = await checkNikService.fetchNIK(nikController.text);
      if (response.data['responseCode'] == "00") {
        Get.snackbar("Success", "NIK is valid");
        return true;
      } else if (response.statusCode == 400) {
        Get.snackbar("Error", "Invalid NIK");
        return false;
      } else {
        Get.snackbar("Error", "Failed to validate NIK");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  Future<void> fetchNikData() async {
    if (nikController.text.isEmpty) {
      Get.snackbar("Error", "NIK field cannot be empty");
      return;
    }

    final checkNikService = CheckNik();

    String formatDate(String? dateString) {
      if (dateString == null || dateString.isEmpty) {
        return 'Tidak Ada';
      }

      try {
        // Handle ISO format or other date formats
        final DateTime parsedDate = dateString.contains('T')
            ? DateTime.parse(dateString)
            : DateFormat('yyyy-MM-dd').parse(dateString);

        // Format to Indonesian format: dd-MMMM-yyyy
        final DateFormat formatter = DateFormat('dd-MMMM-yyyy', 'id_ID');
        return formatter.format(parsedDate);
      } catch (e) {
        print('Error formatting date: $e');
        return dateString;
      }
    }

    try {
      final response = await checkNikService.fetchNIK(nikController.text);
      bool status =
          response.data != null && response.data['responseCode'] == "00";

      print(status);

      final anggotaResponse = AnggotaResponse.fromJson(response.data);
      if (status) {
        print(">>> AnggotaResponse: ${anggotaResponse.toJson()}");
        setCif(anggotaResponse.owner?.cifId ?? 0);
        print(cifId);
        namaAwalController.text = anggotaResponse.owner?.firstName ?? '';
        namaAkhirController.text = anggotaResponse.owner?.lastName ?? '';
        namaPasanganController.text = anggotaResponse.owner?.pasanganNama ?? '';
        nikpasaganController.text = anggotaResponse.owner?.pasanganIdcard ?? '';
        // Format the date before setting it
        tanggallahirController.text =
            formatDate(anggotaResponse.owner?.dateBorn?.toString());
        telpController.text = anggotaResponse.address?.phone ?? '';
        kotaAsalController.text = anggotaResponse.owner?.cityBorn ?? '';
        pekerjaanController.text =
            anggotaResponse.address?.deskripsiPekerjaan ?? '';
        postalCodeController.text = anggotaResponse.address?.postalCode ?? '';
        detileAlamatController.text =
            anggotaResponse.address?.addressDetile ?? '';
        selectedGender.value = anggotaResponse.owner?.gender?.toString() ?? '';

        Get.snackbar("Success", "NIK data fetched successfully");
      } else {
        Get.snackbar("Error", "No data found for the provided NIK");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      print(e);
    }
  }

  Future<void> saveForm() async {
    if (nikController.text.isEmpty ||
        namaAwalController.text.isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar("Gagal", "Pastikan semua data terisi termasuk gender");
      return;
    }

    final createCIFService = CreateCIFService();

    try {
      final parts = alamatController.text.split('-');

      final region = parts.length > 1 ? parts[1] : '';
      final sector = parts.length > 2 ? parts[2] : '';
      final village = parts.length > 3 ? parts[3] : '';

      final response = await createCIFService.createCIF(
        idLegal: 3319123456,
        officeId: "000",
        enikNo: nikController.text,
        enikType: "K05",
        firstName: namaAwalController.text,
        lastName: namaAkhirController.text,
        cityBorn: kotaAsalController.text,
        pasanganNama: namaPasanganController.text,
        pasanganIdCart: nikpasaganController.text,
        region: region,
        sector: sector,
        village: village,
        scopeVillage: "004-005",
        addressLine1: detileAlamatController.text,
        pemberiKerja: pekerjaanController.text,
        postalCode: postalCodeController.text,
        deskripsiPekerjaan: pekerjaanController.text,
        phone: telpController.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Data berhasil disimpan");
        print("Response: ${response.data}");
        final CifResponse cifResponse = CifResponse.fromJson(response.data);
        setCif(cifResponse.cifId);
      } else {
        Get.snackbar("Gagal", "Gagal menyimpan data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan: $e");
    }
  }

  Future<void> pickImageFromGallery(bool isKtp) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isKtp) {
        fotoKtp.value = File(pickedFile.path);
      } else {
        buktiJaminan.value = File(pickedFile.path);
      }
    }
  }

  void setImageFromCamera(String path, bool isKtp) {
    if (isKtp) {
      fotoKtp.value = File(path);
    } else {
      buktiJaminan.value = File(path);
    }
  }

  void clearForm() {
    selectedGender.value = '';
    nikController.clear();
    namaAwalController.clear();
    namaAkhirController.clear();
    namaPasanganController.clear();
    tanggallahirController.clear();
    kotaAsalController.clear();
    nikpasaganController.clear();
    telpController.clear();
    pekerjaanController.clear();
    postalCodeController.clear();
    alamatController.clear();
    nominalController.clear();
    jenisJaminanController.clear();
    fotoKtp.value = null;
    buktiJaminan.value = null;
  }

  RxInt cifResponse = 0.obs;

  void setCif(int data) {
    cifResponse.value = data;
  }

  int? get cifId => cifResponse.value;

  bool validateForm() {
    if (nikController.text.isEmpty ||
        namaAwalController.text.isEmpty ||
        namaAkhirController.text.isEmpty ||
        namaPasanganController.text.isEmpty ||
        tanggallahirController.text.isEmpty ||
        kotaAsalController.text.isEmpty ||
        telpController.text.isEmpty ||
        pekerjaanController.text.isEmpty ||
        alamatController.text.isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar("Error", "All fields must be filled");
      return false;
    }
    return true;
  }

  Future<void> onSubmit(BuildContext context) async {
  if (validateForm()) {
    final nikDataExists = await checkNik();
    if (!nikDataExists) {
      saveForm();
    }
    clearForm();
    Get.toNamed(MyAppRoutes.dataPinjaman);
  } else {
    Get.snackbar(
      'Error',
      'Please fill all fields correctly.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}

}