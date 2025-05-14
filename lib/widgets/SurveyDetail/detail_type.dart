import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class CollateralTypeWidget extends StatelessWidget {
  final DetailController controller = Get.find<DetailController>();

  CollateralTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => FieldReadonly(
          label: 'Jenis Jaminan',
          width: double.infinity,
          height: 50,
          controller: TextEditingController(
            text: controller.collateralType.value,
          ),
          keyboardType: TextInputType.text,
        ));
  }
}
