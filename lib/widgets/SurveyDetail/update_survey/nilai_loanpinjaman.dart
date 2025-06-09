import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/update_survey/fieldeditingtab.dart';

class LoanAngkaPinjaman_Update extends StatelessWidget {
  final SurveyController controller = Get.find<SurveyController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FieldEditable(
          label: 'Pebgajuan Pinjaman',
          controller: controller.plafondController,
          keyboardType: TextInputType.number,
        ),
        FieldEditable(
          label: 'Taksiran Nilai Jaminan',
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
