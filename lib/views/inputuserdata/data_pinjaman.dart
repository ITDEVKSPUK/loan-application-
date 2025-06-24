import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/views/inputuserdata/financial_form_section.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class DataPinjaman extends StatefulWidget {
  const DataPinjaman({super.key});

  @override
  State<DataPinjaman> createState() => _DataPinjamanState();
}

final controller = Get.put(CreditFormController());

class _DataPinjamanState extends State<DataPinjaman> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed('/dashboard');
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: 'Data Pinjaman',
            onBack: () => Get.back(),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Tujuan Kredit & Jaminan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                FinancialFormSection(controller: controller),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.validateForm()) {
                        controller.createSurvey();
                        Get.toNamed(MyAppRoutes.formAgunan);
                      } else {
                        Get.snackbar("Error", "Please fill all fields correctly");
                      }
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
                      'Save & Next',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.pureWhite,
                        fontFamily: 'Outfit',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
