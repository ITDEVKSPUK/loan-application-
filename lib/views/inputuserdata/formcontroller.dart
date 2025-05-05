import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/models/anggota_models.dart';
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
      final response = await checkNikService.fetchNIK();
      if (response.data != null) {
        final anggotaResponse = AnggotaResponse.fromJson(response.data);
        namaAwalController.text = anggotaResponse.owner?.firstName ?? '';
        namaAkhirController.text = anggotaResponse.owner?.lastName ?? '';
        namaPasanganController.text = anggotaResponse.owner?.spouseName ?? '';
        nikpasaganController.text = anggotaResponse.owner?.spouseIdCard ?? '';
        tanggallahirController.text = anggotaResponse.owner?.dateOfBirth ?? '';
        telpController.text = anggotaResponse.owner?.phoneNumber ?? '';
        kotaAsalController.text = anggotaResponse.addres?.city ?? '';
        pekerjaanController.text = anggotaResponse.owner?.occupation ?? '';
        alamatController.text = anggotaResponse.addres?.addressLine1 ?? '';
        Get.snackbar("Success", "NIK data fetched successfully");
      } else {
        Get.snackbar("Error", "No data found for the provided NIK");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
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

  void saveForm() {
    if (nikController.text.isEmpty ||
        namaAwalController.text.isEmpty ||
        selectedGender.value.isEmpty) {
      Get.snackbar("Gagal", "Pastikan semua data terisi termasuk gender");
      return;
    }
    final data = {
      "gender": selectedGender.value,
      "nik": nikController.text,
      "namaAwal": namaAwalController.text,
      "namaAkhir": namaAkhirController.text,
      "namaPasagan": namaPasanganController.text,
      "nikPasangan": nikpasaganController.text,
      "tanggalLahir": tanggallahirController.text,
      "kotaAsal": kotaAsalController.text,
      "telp": telpController.text,
      "pekerjaan": pekerjaanController.text,
      "alamat": alamatController.text,
      "nominal": nominalController.text,
      "jenisJaminan": jenisJaminanController.text,
      "fotoKtp": fotoKtp.value?.path,
      "buktiJaminan": buktiJaminan.value?.path,
    };
    print("DATA YANG DISIMPAN: $data");
    Get.snackbar("Berhasil", "Data berhasil disimpan");
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
}
