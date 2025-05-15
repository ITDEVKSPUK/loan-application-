import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class Loan_angkaPinjaman extends StatelessWidget {
  final controller = Get.find<InqurySurveyController>();

  String formatRupiah(String numberString) {
    if (numberString.isEmpty) return 'Rp0';
    final number =
        int.tryParse(numberString.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return 'Rp${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            FieldReadonly(
              label: 'Plafon Pinjaman',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.plafond.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Nominal Peminjaman',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.value.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Pendapatan Bulanan',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.income.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Total Aset',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.asset.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Pengeluaran Perbulan',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.expenses.value),
              keyboardType: TextInputType.number,
            ),
            FieldReadonly(
              label: 'Angsuran Perbulan',
              width: double.infinity,
              height: 50,
              value: formatRupiah(controller.installment.value),
              keyboardType: TextInputType.number,
            ),
          ],
        ));
  }
}
