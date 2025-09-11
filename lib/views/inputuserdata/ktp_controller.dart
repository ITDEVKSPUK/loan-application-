import 'dart:io';

import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:loan_application/API/models/ktp_models.dart';

class KtpController extends GetxController {
  final rawLines = <String>[].obs;
  final parsedData = KtpModel().obs;

  /// Scan gambar KTP pakai OCR
  Future<void> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    // simpan raw lines
    rawLines.assignAll(recognizedText.text.split("\n"));

    // parsing
    parsedData.value = _parseKtp(rawLines);

    await textRecognizer.close();
  }

  KtpModel _parseKtp(List<String> lines) {
    final data = KtpModel();

    // 🔹 Cari NIK
    for (var line in lines) {
      data.nik ??= _extractNik(line);
    }

    // 🔹 Kandidat nama (huruf kapital semua, panjang >= 3, tidak mengandung kata blacklist)
    final blacklist = [
      "provinsi",
      "kabupaten",
      "nik",
      "lahir",
      "alamat",
      "agama",
      "status",
      "perkawinan",
      "pekerjaan",
      "berlaku",
      "kecamatan",
      "desa",
      "kel",
      "rt",
      "rw",
      "gol",
      "darah",
      "laki",
      "perempuan",
      "islam",
      "kristen",
      "katolik",
      "hindu",
      "buddha",
      "konghucu",
    ];

    final cleaned = lines.where((line) {
      final text = line.trim();
      final l = text.toLowerCase();

      return RegExp(r'^[A-Z\s]{3,}$').hasMatch(text) &&
          blacklist.every((word) => !l.contains(word));
    }).toList();

    // 🔹 Ambil kandidat nama paling atas
    if (cleaned.isNotEmpty) {
      data.nama = cleaned.first.trim();
    }

    return data;
  }

  /// Ekstrak NIK dengan aman
  String? _extractNik(String line) {
    // cari angka 16 digit murni
    final nikMatch = RegExp(r'\b\d{16}\b').firstMatch(line);
    if (nikMatch != null) return nikMatch.group(0);

    // fallback: koreksi huruf mirip angka
    final fixed = line
        .replaceAll("O", "0")
        .replaceAll("o", "0")
        .replaceAll("I", "1")
        .replaceAll("L", "1");

    final fixedMatch = RegExp(r'\b\d{16}\b').firstMatch(fixed);
    return fixedMatch?.group(0);
  }
}
