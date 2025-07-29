import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';

class UploadKTPPicker extends StatelessWidget {
  final CreditFormController controller;

  const UploadKTPPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.pickKTPImages(context),
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
                          text: 'upload KTP',
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
        Obx(() {
          final images = controller.selectedKTPImages;
          if (images.isEmpty) {
            return const Text("Belum ada foto KTP yang dipilih.");
          }
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
                            controller.selectedKTPImages.removeAt(index),
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
          );
        }),
      ],
    );
  }
}