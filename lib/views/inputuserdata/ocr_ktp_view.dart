import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:loan_apllication/views/employee/inputuserdata/ocr_controller.dart';

class FormKtpSection extends StatelessWidget {
  FormKtpSection({super.key});

  final ocrController = Get.put(OcrController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Foto KTP',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),

        // Gambar KTP
        GestureDetector(
          onTap: ocrController.pickImageFromGallery,
          child: Obx(() {
            return Container(
              width: 317,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: ocrController.fotoKtp.value != null
                      ? FileImage(ocrController.fotoKtp.value!)
                      : AssetImage('assets/images/rawktp.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 16),

        // Hasil OCR (text)
        Text(
          'Hasil Scan OCR:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        StreamBuilder<String>(
          stream: ocrController.ocrStream.stream,
          builder: (context, snapshot) {
            return Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                snapshot.data ?? 'Belum ada hasil OCR',
                style: const TextStyle(fontSize: 14),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Komponen OCR Scanner Live
        Text(
          'Scan KTP (opsional)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ScalableOCR(
            paintboxCustom: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4.0
              ..color = const Color.fromARGB(153, 102, 160, 241),
            boxLeftOff: 4,
            boxBottomOff: 2.7,
            boxRightOff: 4,
            boxTopOff: 2.7,
            boxHeight: MediaQuery.of(context).size.height / 5,
            getRawData: (value) {},
            getScannedText: (value) => ocrController.setOcrText(value),
          ),
        ),
      ],
    );
  }
}
