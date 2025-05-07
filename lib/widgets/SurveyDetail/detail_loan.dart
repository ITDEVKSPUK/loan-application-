import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';

class LoanAmountWidget extends StatelessWidget {
  final controller = Get.find<DetailController>();

   LoanAmountWidget({super.key});

  String formatRupiah(String numberString) {
    if (numberString.isEmpty) return 'Rp0';
    final number = int.tryParse(numberString.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return 'Rp${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => FieldReadonly(
          label: 'Nominal Peminjaman',
          width: double.infinity,
          height: 50,
          controller: TextEditingController(
            text: formatRupiah(controller.loanAmount.value),
          ),
          keyboardType: TextInputType.number,
        ));
  }
}
