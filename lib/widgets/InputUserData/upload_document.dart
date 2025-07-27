import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';

class UploadDocumentPicker extends StatelessWidget {
  final CreditFormController controller;

  const UploadDocumentPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown kategori dokumen
        Obx(() {
          return DropdownButtonFormField<String>(
            value: controller.selectedDocument.value.isEmpty
                ? null
                : controller.selectedDocument.value,
            decoration: InputDecoration(
              labelText: "Kategori Dokumen *",
              labelStyle: TextStyle(color: const Color.fromARGB(255, 138, 138, 138)),
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
                borderSide: BorderSide(color: const Color.fromARGB(255, 179, 203, 255), width: 2),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 238, 238),
              errorText: controller.selectedDocument.value.isEmpty
                  ? "Kategori Dokumen wajib dipilih"
                  : null,
            ),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: const Color.fromARGB(255, 139, 143, 147)),
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
              final selected = controller.documentList.firstWhere(
                (e) => e['id_catdocument'].toString() == val,
                orElse: () => {},
              );
              controller.selectedDocument.value = val!;
              controller.selectedDocumentName.value = selected['name'] ?? '';
            },
          );
        }),
        const SizedBox(height: 12),

        // Area upload dengan DottedBorder
        GestureDetector(
          onTap: () => controller.pickDocumentImages(context),
          child: DottedBorder(
            color: Colors.blue.shade300,
            strokeWidth: 1.5,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload, size: 40, color: Colors.blue.shade600),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Klik untuk ',
                      children: [
                        TextSpan(
                          text: 'upload Dokumen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700),
                        )
                      ],
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Preview gambar dokumen
        Obx(() {
          final images = controller.selectedDocumentImages;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (images.isEmpty)
                const Text("Belum ada dokumen yang dipilih.")
              else
                SizedBox(
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
                              onTap: () => controller.selectedDocumentImages.removeAt(index),
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
                    },
                  ),
                ),
              const SizedBox(height: 12),
              if (images.isEmpty)
                Text(
                  "Dokumen wajib diunggah",
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
            ],
          );
        }),
      ],
    );
  }
}
