import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputDataController extends GetxController {

  
  // Controller untuk tiap TextField
  final nikController = TextEditingController();
  final namaController = TextEditingController();
  final telpController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final alamatController = TextEditingController();
  final nominalController = TextEditingController();
  final jenisJaminanController = TextEditingController();

  // Gambar KTP & Jaminan
  Rx<File?> fotoKtp = Rx<File?>(null);
  Rx<File?> buktiJaminan = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  Future<void> pickImageKtp() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fotoKtp.value = File(pickedFile.path);
    }
  }

  Future<void> pickImageJaminan() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      buktiJaminan.value = File(pickedFile.path);
    }
  }

  void clearForm() {
    nikController.clear();
    namaController.clear();
    telpController.clear();
    pekerjaanController.clear();
    alamatController.clear();
    nominalController.clear();
    jenisJaminanController.clear();
    fotoKtp.value = null;
    buktiJaminan.value = null;
  }

  void saveForm() {
    final data = {
      "nik": nikController.text,
      "nama": namaController.text,
      "telp": telpController.text,
      "pekerjaan": pekerjaanController.text,
      "alamat": alamatController.text,
      "nominal": nominalController.text,
      "jenisJaminan": jenisJaminanController.text,
      "fotoKtp": fotoKtp.value?.path,
      "buktiJaminan": buktiJaminan.value?.path,
    };

    // Terserah lo mau kirim ke API, SQLite, atau print dulu
    print("DATA YANG DISIMPAN: $data");
    Get.snackbar("Berhasil", "Data berhasil disimpan");
  }

  @override
  void onClose() {
    nikController.dispose();
    namaController.dispose();
    telpController.dispose();
    pekerjaanController.dispose();
    alamatController.dispose();
    nominalController.dispose();
    jenisJaminanController.dispose();
    super.onClose();
  }
}
