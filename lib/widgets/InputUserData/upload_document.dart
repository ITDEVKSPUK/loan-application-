import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';

class UploadDocumentPicker extends StatelessWidget {
  final CreditFormController controller;

  const UploadDocumentPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return DropdownButtonFormField<String>(
            value: controller.selectedDocument.value.isEmpty
                ? null
                : controller.selectedDocument.value,
            decoration: const InputDecoration(labelText: "Kategori Dokumen"),
            items: controller.documentList.map((doc) {
              return DropdownMenuItem<String>(
                value: doc['id_catdocument'].toString(),
                child: Text(doc['name']),
              );
            }).toList(),
            onChanged: (val) => controller.selectedDocument.value = val!,
          );
        }),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => controller.pickDocumentImages(context),
          icon: const Icon(Icons.upload_file),
          label: const Text("Upload Dokumen"),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final images = controller.selectedDocumentImages;
          if (images.isEmpty) return const Text("Belum ada gambar");

          return SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    Image.file(images[index],
                        width: 80, height: 80, fit: BoxFit.cover),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => images.removeAt(index),
                        child: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
