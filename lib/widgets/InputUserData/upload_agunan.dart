import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
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
        // Dropdown kategori agunan
        // TextField dropdown custom
        Obx(() {
          return TextFormField(
            readOnly: true,
            controller: controller.selectedAgunanName,
            decoration: InputDecoration(
              labelText: "Kategori Agunan *",
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
              errorText: controller.selectedAgunan.value.isEmpty
                  ? "Kategori Agunan wajib dipilih"
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
                          'Pilih Kategori Agunan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.agunanList.length,
                          itemBuilder: (context, index) {
                            final agunan = controller.agunanList[index];
                            final isSelected =
                                controller.selectedAgunan.value ==
                                    agunan['ida'].toString();

                            return ListTile(
                              title: Text(agunan['descript']),
                              trailing: isSelected
                                  ? Icon(Icons.check, color: Colors.blue)
                                  : null,
                              selected: isSelected,
                                onTap: () {
                                Get.back(result: agunan);
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
                // ✅ Gunakan method baru untuk set selected agunan
                controller.setSelectedAgunan(result);
              }
            },
          );
        }),
        const SizedBox(height: 12),

        // Upload dengan DottedBorder (hilang jika sudah ada gambar)
        Obx(() {
          return controller.selectedAgunanImages.isEmpty
              ? GestureDetector(
                  onTap: () => controller.pickAgunanImages(context),
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
                                  text: 'upload foto Agunan',
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
              : const SizedBox(); // kosongkan jika ada gambar
        }),

        const SizedBox(height: 12),

        // Preview gambar Agunan
        Obx(() {
          final images = controller.selectedAgunanImages;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (images.isEmpty)
                const Text("Belum ada gambar yang dipilih.")
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

              // Deskripsi Agunan
              TextField(
                decoration: InputDecoration(
                  labelText: "Tambahkan Deskripsi Agunan",
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 138, 138, 138)),
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
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 179, 203, 255),
                        width: 2),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 238, 238),
                  errorText: controller.addDescript.text.isEmpty
                      ? "Deskripsi wajib diisi"
                      : null,
                ),
                controller: controller.addDescript,
              ),
              const SizedBox(height: 12),

              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  MoneyInputFormatter(
                    thousandSeparator: ThousandSeparator.Period,
                    mantissaLength: 0,
                  ),
                ],
                decoration: InputDecoration(
                  labelText: "Taksiran Nilai Agunan *",
                  labelStyle: TextStyle(
                      color: const Color.fromARGB(255, 138, 138, 138)),
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
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 179, 203, 255),
                        width: 2),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 238, 238, 238),
                  errorText: controller.marketValue.text.isEmpty
                      ? "Nilai taksiran wajib diisi"
                      : null,
                ),
                controller: controller.marketValue,
              ),
            ],
          );
        }),
      ],
    );
  }
}
