import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KtpPreviewScreen extends StatelessWidget {
  final File imageFile;
  final VoidCallback onConfirm;

  const KtpPreviewScreen({
    Key? key,
    required this.imageFile,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pratinjau Foto KTP')),
      body: Column(
        children: [
          Expanded(
            child: Image.file(
              imageFile,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.close, color: Colors.white),
                  label: const Text('Ulangi',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Get.back(); // kembali ke kamera
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text('Gunakan',
                      style: TextStyle(color: Colors.white)),
                  onPressed: onConfirm,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
