import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loan_application/API/models/anggota_models.dart';
import 'package:loan_application/API/service/post_nik_check.dart';

class InputDataController extends GetxController {
  final nikController = TextEditingController();
  final namaAwalController = TextEditingController();
  final namaAkhirController = TextEditingController();
  final namaPasanganController = TextEditingController();
  final kotaAsalController = TextEditingController();
  final telpController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final alamatController = TextEditingController();
  final nominalController = TextEditingController();
  final jenisJaminanController = TextEditingController();

  Rx<File?> fotoKtp = Rx<File?>(null);
  Rx<File?> buktiJaminan = Rx<File?>(null);

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
        namaAwalController.text = anggotaResponse.owner?. firtsName ?? '';
        namaAkhirController.text = anggotaResponse.owner?. lastName ?? '';
        telpController.text = anggotaResponse.addres?.phone ?? '';
        kotaAsalController.text = anggotaResponse.addres?.phone ?? '';
        pekerjaanController.text =
            anggotaResponse.addres?.deskripsiPekerjaan ?? '';
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
    nikController.clear();
    namaAwalController.clear();
    namaAkhirController.clear();
    namaPasanganController.clear();
    kotaAsalController.clear();
    telpController.clear();
    pekerjaanController.clear();
    alamatController.clear();
    nominalController.clear();
    jenisJaminanController.clear();
    fotoKtp.value = null;
    buktiJaminan.value = null;
  }

  void saveForm() {
  if (nikController.text.isEmpty || namaAwalController.text.isEmpty) {
    Get.snackbar("Gagal", "Pastikan semua data terisi");
    return;
  }
    final data = {
      "nik": nikController.text,
      "namaAwal": namaAwalController.text,
      "namaAkhir": namaAkhirController.text,
      "namaPasagan": namaPasanganController.text,
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
    kotaAsalController.dispose();
    telpController.dispose();
    pekerjaanController.dispose();
    alamatController.dispose();
    nominalController.dispose();
    jenisJaminanController.dispose();
    super.onClose();
  }
}
