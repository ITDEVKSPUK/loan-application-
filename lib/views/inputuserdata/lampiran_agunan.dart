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
import 'package:loan_application/widgets/textfield_form.dart';

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
          title: const Text("Form Pengajuan Kredit"),
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
              const Text("📝 Tujuan Kredit & Jaminan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              UploadAgunanPicker(controller: controller),
              const SizedBox(height: 16),
              UploadDocumentPicker(controller: controller),
              const SizedBox(height: 16),
              FinancialFormSection(controller: controller),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () => controller.handleSubmit(context),
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
