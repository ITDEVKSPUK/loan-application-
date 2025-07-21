import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/widgets/InputUserData/upload_agunan.dart';
import 'package:loan_application/widgets/InputUserData/upload_document.dart';
import 'package:loan_application/widgets/InputUserData/upload_ktp.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class FullCreditFormPage extends StatefulWidget {
  const FullCreditFormPage({super.key});

  @override
  State<FullCreditFormPage> createState() => _FullCreditFormPageState();
}

class _FullCreditFormPageState extends State<FullCreditFormPage> {
  final controller = Get.put(CreditFormController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: CustomAppBar(
          title: 'Lampiran Dokumen',
          onBack: () => Get.back(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(
                child: const Text("Upload Bukti",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 16),
              UploadKTPPicker(controller: controller),
              const SizedBox(height: 12),
              UploadAgunanPicker(controller: controller),
              const SizedBox(height: 16),
              UploadDocumentPicker(controller: controller),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.handleSubmit(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.casualbutton1,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.pureWhite,
                      fontFamily: 'Outfit',
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
