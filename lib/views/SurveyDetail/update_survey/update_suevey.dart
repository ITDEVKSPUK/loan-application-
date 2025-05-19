import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/service/put_update_survey.dart';
import 'package:loan_application/views/SurveyDetail/update_survey/update_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_bukti_agunan.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/fieldeditingtab.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/nilai_loanpinjaman.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/nilai_pinjamUpdate.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class UpdateSuevey extends StatefulWidget {
  @override
  State<UpdateSuevey> createState() => _UpdateSueveyState();
}

class _UpdateSueveyState extends State<UpdateSuevey> {
  @override
  void initState() {
    super.initState();
    Get.put(
        UpdateSurveyController(putUpdateSurvey: Get.put(PutUpdateSurvey())));
    final trxSurvey = Get.arguments;
    Get.find<UpdateSurveyController>().loadSurveyData(trxSurvey);
    print("trx survey (update): $trxSurvey");
  }

  @override
  void dispose() {
    Get.delete<UpdateSurveyController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UpdateSurveyController updateController =
        Get.find<UpdateSurveyController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Update Debitur Document',
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.save),
                onPressed: updateController.isLoading.value
                    ? null
                    : () {
                        updateController.saveSurvey();
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
                  Category_agunan(),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldEditable(
                        label: 'Tujuan Pinjaman',
                        controller: updateController.purposeController,
                        keyboardType: TextInputType.text,
                      ),
                      FieldEditable(
                          label: 'Deskripsi Pinjaman',
                          controller:
                              updateController.collateralAddDescController,
                          keyboardType: TextInputType.text),
                      LoanAngkaPinjaman_Update(),
                      NilaiPinjamanUpdate(),
                    ],
                  ),
                ],
              ),
            ),
            Obx(() => updateController.isLoading.value
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
