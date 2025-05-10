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
            decoration: InputDecoration(
              labelText: "Kategori Dokumen",
              labelStyle: TextStyle(color: Colors.blue.shade700),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
              ),
              filled: true,
              fillColor: Colors.blue.shade50,
            ),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade700),
            items: controller.documentList.map((doc) {
              return DropdownMenuItem<String>(
                value: doc['id_catdocument'].toString(),
                child: Text(
                  doc['name'],
                  style: const TextStyle(fontSize: 15),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) controller.selectedDocument.value = val;
            },
          );
        }),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => controller.pickDocumentImages(context),
          icon: const Icon(Icons.upload_file, color: Colors.white),
          label: const Text(
            "Upload Dokumen",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade600,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          final images = controller.selectedDocumentImages;
          if (images.isEmpty)
            return const Text("Belum ada dokumen yang dipilih.");

          return SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        images[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () =>
                            controller.selectedDocumentImages.removeAt(index),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                );
              }
            ),
          );
        }),
      ],
    );
  }
}
