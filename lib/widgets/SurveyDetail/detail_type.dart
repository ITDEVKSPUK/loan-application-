import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class CollateralTypeWidget extends StatelessWidget {
  final SurveyController controller = Get.find<SurveyController>();

  CollateralTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => FieldReadonly(
          label: 'Category Agunan',
          width: double.infinity,
          height: 50,
          value: controller.document_type.value,
          keyboardType: TextInputType.text,
        ));
  }
}