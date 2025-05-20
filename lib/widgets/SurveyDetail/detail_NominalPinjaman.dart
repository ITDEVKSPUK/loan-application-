import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class LoanAngkaPinjaman extends StatelessWidget {
  final controller = Get.find<InqurySurveyController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            FieldReadonly(
              label: 'Nilai Peminjaman',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.value.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Nominal Pinjaman',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.plafond.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Pendapatan Bulanan',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.income.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Total Aset',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.asset.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Pengeluaran Perbulan',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.expenses.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Angsuran Perbulan',
              width: double.infinity,
              height: 50,
              value: controller.formatRupiah(controller.installment.value),
              keyboardType: TextInputType.number,
            ),
          ],
        ));
  }
}