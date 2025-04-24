import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class InputDataController extends GetxController {
  final nikController = TextEditingController();
  final namaController = TextEditingController();
  final telpController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final alamatController = TextEditingController();
  final nominalController = TextEditingController();
  final jenisJaminanController = TextEditingController();

  Rx<File?> fotoKtp = Rx<File?>(null);
  Rx<File?> buktiJaminan = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  get pickImageJaminan => null;

  // Ambil dari Galeri
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
  if (nikController.text.isEmpty || namaController.text.isEmpty) {
    Get.snackbar("Gagal", "Pastikan semua data terisi");
    return;
  }
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
