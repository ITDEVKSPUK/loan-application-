import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_NominalPinjaman.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application/widgets/custom_appbar.dart';
import 'package:loan_application/API/service/put_update_survey.dart';

class DetailSurvey extends StatefulWidget {
  const DetailSurvey({super.key});

  @override
  State<DetailSurvey> createState() => _DetailSurveyState();
}

class _DetailSurveyState extends State<DetailSurvey> {
  @override
  void initState() {
    super.initState();
    // Initialize SurveyController
    Get.put(SurveyController(putUpdateSurvey: Get.put(PutUpdateSurvey())));
    final trxSurvey = Get.arguments;
    Get.find<SurveyController>().getSurveyList(trxSurvey: trxSurvey.toString());
    print("trx survey: $trxSurvey");
  }

  @override
  void dispose() {
    // Do not dispose SurveyController here since it needs to persist for UpdateSurvey
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SurveyController controller = Get.find<SurveyController>();
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Detail Documen',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final inquiryData = controller.inquiryModel.value;
              if (inquiryData == null) {
                Get.snackbar(
                  'Error',
                  'Data inquiry tidak tersedia',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }
              Get.toNamed(
                MyAppRoutes.updateSurvey,
                arguments: {'trxSurvey': inquiryData.application.trxSurvey},
              );
            },
          ),
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
                  Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FieldReadonly(
                            label: 'Tujuan Pinjaman',
                            width: double.infinity,
                            height: 50,
                            value: controller.purpose.value,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 4),
                          FieldReadonly(
                            label: 'Category Document',
                            width: double.infinity,
                            height: 50,
                            value: controller.adddescript.value,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          LoanAngkaPinjaman(),
                        ],
                      )),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(
                        MyAppRoutes.detaildocumen,
                        arguments: Get.arguments,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.selanjutnyabutton,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Selanjutnya',
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.pureWhite,
                                fontFamily: 'Outfit'),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_outlined,
                              color: Colors.white),
                        ],
                      ),
                    ),
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
      )
    );
  }
}
