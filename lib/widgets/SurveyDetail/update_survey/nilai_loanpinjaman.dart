import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/SurveyDetail/update_survey/update_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/fieldeditingtab.dart';

class LoanAngkaPinjaman_Update extends StatelessWidget {
  final UpdateSurveyController controller = Get.find<UpdateSurveyController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldEditable(
          label: 'Plafon Pinjaman',
          controller: controller.plafondController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Nominal Peminjaman',
          controller: controller.valueController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Pendapatan Bulanan',
          controller: controller.incomeController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Total Aset',
          controller: controller.assetController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Pengeluaran Perbulan',
          controller: controller.expenseController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Angsuran Perbulan',
          controller: controller.installmentController,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
