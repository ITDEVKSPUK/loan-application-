import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OcrController extends GetxController {
  final StreamController<String> ocrStream = StreamController<String>();
  final fotoKtp = Rxn<File>();
  final nikResult = ''.obs;

  void setOcrText(String value) {
    ocrStream.add(value);
    nikResult.value = value;
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      fotoKtp.value = File(pickedFile.path);
    }
  }

  @override
  void onClose() {
    ocrStream.close();
    super.onClose();
  }
}
