import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';

class UploadAgunanPicker extends StatelessWidget {
  final CreditFormController controller;

  const UploadAgunanPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return DropdownButtonFormField<String>(
            value: controller.selectedAgunan.value.isEmpty
                ? null
                : controller.selectedAgunan.value,
            decoration: const InputDecoration(
              labelText: "Kategori Agunan",
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.black,
            ),
            items: controller.agunanList.map((agunan) {
              return DropdownMenuItem<String>(
                value: agunan['ida'].toString(),
                child: Text(
                  agunan['descript'],
                  style: const TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 14),
                ),
              );
            }).toList(),
            onChanged: (val) => controller.selectedAgunan.value = val!,
          );
        }),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => controller.pickAgunanImages(context),
          icon: const Icon(Icons.camera_alt),
          label: const Text(
            "Upload Foto Agunan",
            style: TextStyle(fontFamily: 'Montserrat'),
          ),
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 14),
          ),
        ),
        const SizedBox(height: 8),
        Obx(() {
          final images = controller.selectedAgunanImages;
          if (images.isEmpty) {
            return const Text(
              "Belum ada gambar",
              style: TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 14, color: Colors.grey),
            );
          }

          return SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    Image.file(
                      images[index],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
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
