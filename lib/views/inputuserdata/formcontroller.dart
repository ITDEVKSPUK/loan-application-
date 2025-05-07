import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/models/anggota_models.dart';
import 'package:loan_application/API/models/cif_models.dart';
import 'package:loan_application/API/service/post_create_CIF.dart';
import 'package:loan_application/API/service/post_nik_check.dart';

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

  Rx<File?> fotoKtp = Rx<File?>(null);
  Rx<File?> buktiJaminan = Rx<File?>(null);
  RxString selectedGender = ''.obs;
  final Rx<DateTime> startDate = DateTime.now().obs;
  final RxString selectedDateText = ''.obs;
  final RxString selectedDate = ''.obs;

  final ImagePicker _picker = ImagePicker();

  get pickImageJaminan => null;

  Future<void> fetchNikData() async {
    if (nikController.text.isEmpty) {
      Get.snackbar("Error", "NIK field cannot be empty");
      return;
    }

    final checkNikService = CheckNik();

    try {
      final response = await checkNikService.fetchNIK(nikController.text);
      if (response.data != null) {
        final anggotaResponse = AnggotaResponse.fromJson(response.data);
        namaAwalController.text = anggotaResponse.owner?.firstName ?? '1';
        namaAkhirController.text = anggotaResponse.owner?.lastName ?? '';
        namaPasanganController.text = anggotaResponse.owner?.pasanganNama ?? '';
        nikpasaganController.text = anggotaResponse.owner?.pasanganIdcard ?? '';
        tanggallahirController.text =
            anggotaResponse.owner?.dateBorn.toString() ?? '';
        telpController.text = anggotaResponse.address?.phone ?? '';
        kotaAsalController.text = anggotaResponse.address?.region ?? '';
        pekerjaanController.text = anggotaResponse.address?.kodePekerjaan ?? '';
        alamatController.text = anggotaResponse.address?.addressLine1 ?? '';
        selectedGender.value = anggotaResponse.owner?.gender.toString() ?? '';
        Get.snackbar("Success", "NIK data fetched successfully");
      } else {
        Get.snackbar("Error", "No data found for the provided NIK");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
      final response = await createCIFService.createCIF(
        idLegal: int.tryParse(nikController.text) ?? 0,
        officeId: "000", // Replace with dynamic office ID if needed
        enikNo: nikController.text,
        enikType: "K05", // Replace with dynamic type if needed
        firstName: namaAwalController.text,
        lastName: namaAkhirController.text,
        cityBorn: kotaAsalController.text,
        pasanganNama: namaPasanganController.text,
        pasanganIdCart: nikpasaganController.text,
        region: kotaAsalController.text,
        sector: pekerjaanController.text,
        village: alamatController.text,
        scopeVillage: "004-005",
        addressLine1: alamatController.text,
        pemberiKerja: pekerjaanController.text,
        deskripsiPekerjaan: pekerjaanController.text,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Berhasil", "Data berhasil disimpan");
        print("Response: ${response.data}");
        final CifResponse cifResponse = CifResponse.fromJson(response.data);
        setCif(cifResponse);
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
    alamatController.clear();
    nominalController.clear();
    jenisJaminanController.clear();
    fotoKtp.value = null;
    buktiJaminan.value = null;
  }

  @override
  void onClose() {
    nikController.dispose();
    namaAwalController.dispose();
    namaAkhirController.dispose();
    namaPasanganController.dispose();
    nikpasaganController.dispose();
    kotaAsalController.dispose();
    telpController.dispose();
    pekerjaanController.dispose();
    alamatController.dispose();
    selectedGenderController.dispose();
    nominalController.dispose();
    jenisJaminanController.dispose();
    super.onClose();
  }

  Rx<CifResponse?> cifResponse = Rx<CifResponse?>(null);

  void setCif(CifResponse data) {
    cifResponse.value = data;
  }

  int? get cifId => cifResponse.value?.cifId;
}
