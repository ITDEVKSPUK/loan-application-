import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:loan_application/views/SurveyDetail/update_survey/update_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/fieldeditingtab.dart';

class NilaiPinjamanUpdate extends StatelessWidget {
  final UpdateSurveyController controller = Get.find<UpdateSurveyController>();

  @override
  Widget build(BuildContext context) {
    return FieldEditable(
          label: 'Nominal Peminjaman',
          controller: controller.valueController,
          keyboardType: TextInputType.number,
        );
  }
}