import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class CollateralTypeWidget extends StatelessWidget {
  final InqurySurveyController controller = Get.find<InqurySurveyController>();

  CollateralTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => FieldReadonly(
          label: 'Category Agunan',
          width: double.infinity,
          height: 50,
          value: controller.plafond.value,
          keyboardType: TextInputType.text,
        ));
  }
}
