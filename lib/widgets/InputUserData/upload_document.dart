import 'package:dotted_border/dotted_border.dart';
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
        // Dropdown kategori dokumen
        Obx(() {
          return TextFormField(
            readOnly: true,
            controller: controller.selectedDocumentName,
            decoration: InputDecoration(
              labelText: "Kategori Dokumen *",
              labelStyle:
                  TextStyle(color: const Color.fromARGB(255, 138, 138, 138)),
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
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 179, 203, 255), width: 2),
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 238, 238, 238),
              errorText: controller.selectedDocument.value.isEmpty
                  ? "Kategori Dokumen wajib dipilih"
                  : null,
              suffixIcon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 139, 143, 147)),
            ),
            onTap: () async {
              final result = await showModalBottomSheet<Map<String, dynamic>>(
                context: Get.context!,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Pilih Kategori Dokumen',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.documentList.length,
                          itemBuilder: (context, index) {
                            final document = controller.documentList[index];
                            final isSelected =
                                controller.selectedDocument.value ==
                                    document['id_catdocument'].toString();

                            return ListTile(
                              title: Text(document['name']),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.blue)
                                  : null,
                              selected: isSelected,
                              onTap: () {
                                Get.back(result: document);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );

              if (result != null) {
                // ✅ Gunakan method baru untuk set selected dokumen
                controller.setSelectedDocument(result);
              }
            },
          );
        }),
        const SizedBox(height: 12),

        // Area upload dengan DottedBorder
        Obx(() {
          return controller.selectedDocumentImages.isEmpty
              ? GestureDetector(
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
                          Icon(Icons.cloud_upload,
                              size: 40, color: Colors.blue.shade600),
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
                )
              : SizedBox();
        }),
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
                  height: 190,
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
                              width: 180,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => controller.selectedDocumentImages
                                  .removeAt(index),
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
