import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/widgets/InputUserData/financial_form_section.dart';
import 'package:loan_application/widgets/InputUserData/upload_agunan.dart';
import 'package:loan_application/widgets/InputUserData/upload_document.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';
import 'package:loan_application/widgets/InputUserData/upload_ktp.dart';

class FullCreditFormPage extends StatefulWidget {
  const FullCreditFormPage({super.key});

  @override
  State<FullCreditFormPage> createState() => _FullCreditFormPageState();
}

class _FullCreditFormPageState extends State<FullCreditFormPage> {
  final controller = Get.put(CreditFormController());

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: AppBar(
          title: const Text("Lampiran Dokumen"),
          backgroundColor: AppColors.pureWhite,
          shadowColor: AppColors.pureWhite,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text("Tujuan Kredit & Jaminan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 16),
              UploadKTPPicker(controller: controller),
              const SizedBox(height: 12),
              UploadAgunanPicker(controller: controller),
              const SizedBox(height: 16),
              UploadDocumentPicker(controller: controller),
              const SizedBox(height: 16),
              FinancialFormSection(controller: controller),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                    onPressed: () => controller.handleSubmit(context),
                    child: const Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, // Warna teks dan ikon
                      backgroundColor: Colors.blue, // Warna latar belakang
                      disabledForegroundColor: Colors.grey
                          .withOpacity(0.38), // Warna teks saat disabled
                      disabledBackgroundColor: Colors.grey.withOpacity(
                          0.12), // Warna latar belakang saat disabled
                      shadowColor: Colors.black, // Warna bayangan
                      elevation: 3, // Tinggi elevasi (bayangan)
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(200, 48), // Ukuran minimum tombol
                      side: const BorderSide(
                          color: Colors.blue, width: 2), // Border/garis tepi
                      alignment:
                          Alignment.center, // Perataan konten di dalam tombol
                    )),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
