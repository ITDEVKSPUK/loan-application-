import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/fieldeditingtab.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/nilai_loanpinjaman.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class UpdateSurvey extends StatefulWidget {
  @override
  State<UpdateSurvey> createState() => _UpdateSurveyState();
}

class _UpdateSurveyState extends State<UpdateSurvey> {
  @override
  void initState() {
    super.initState();
    // Defer loadSurveyData until after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final trxSurvey = Get.arguments;
      Get.find<SurveyController>().loadSurveyData(trxSurvey);
      print("trx survey (update): $trxSurvey");
    });
  }

  @override
  Widget build(BuildContext context) {
    final SurveyController controller = Get.find<SurveyController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Update Debitur Document',
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.save),
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.saveSurvey();
                        // Navigation back to DetailSurvey is handled in saveSurvey
                      },
              )),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldEditable(
                        label: 'Tujuan Pinjaman',
                        controller: controller.purposeController,
                        keyboardType: TextInputType.text,
                      ),
                      FieldEditable(
                        label: 'Category Document',
                        controller: controller.collateralAddDescController,
                        keyboardType: TextInputType.text,
                      ),
                      LoanAngkaPinjaman_Update(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(
                            MyAppRoutes.formAgunan,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.casualbutton1,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Selanjutnya',
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
                ],
              ),
            ),
            Obx(() => controller.isLoading.value
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}