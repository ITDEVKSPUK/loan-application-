import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            decoration: InputDecoration(
              labelText: "Kategori Agunan *",
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
              errorText: controller.selectedAgunan.value.isEmpty
                  ? "Kategori Agunan wajib dipilih"
                  : null,
            ),
            dropdownColor: Colors.white,
            icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade700),
            items: controller.agunanList.map((agunan) {
              return DropdownMenuItem<String>(
                value: agunan['ida'].toString(),
                child: Text(
                  agunan['descript'],
                  style: const TextStyle(fontSize: 15),
                ),
              );
            }).toList(),
            onChanged: (val) {
              final selected = controller.agunanList.firstWhere(
                (e) => e['ida'].toString() == val,
                orElse: () => {},
              );
              controller.selectedAgunan.value = val!;
              controller.selectedAgunanName.value = selected['descript'] ?? '';
              print(
                  'Dropdown selected: ID = $val, Name = ${selected['descript'] ?? 'N/A'}');
            },
          );
        }),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: () => controller.pickAgunanImages(context),
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          label: const Text(
            "Upload Foto Agunan",
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
          final images = controller.selectedAgunanImages;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (images.isEmpty)
                const Text("Belum ada gambar yang dipilih.")
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
                              onTap: () => controller.selectedAgunanImages
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
              Obx(() {
                return TextField(
                  decoration: InputDecoration(
                    labelText: "Tambahkan Deskripsi Agunan",
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
                      borderSide:
                          BorderSide(color: Colors.blue.shade600, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.blue.shade50,
                    errorText: controller.addDescript.value.isEmpty
                        ? "Deskripsi wajib diisi"
                        : null,
                  ),
                  onChanged: (value) {
                    controller.addDescript.value = value;
                    print('Add Descript updated: $value');
                  },
                );
              }),
              SizedBox(height: 12),
              Obx(() {
                return TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // hanya angka
                  ],
                  decoration: InputDecoration(
                    labelText: "Taksiran Nilai Agunan *",
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
                      borderSide:
                          BorderSide(color: Colors.blue.shade600, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.blue.shade50,
                    errorText: controller.marketValue.value.isEmpty
                        ? "Value Market wajib diisi"
                        : null,
                  ),
                  onChanged: (value) {
                    controller.marketValue.value = value;
                    print('Value Market updated: $value');
                  },
                );
              }),
            ],
          );
        }),
      ],
    );
  }
}
