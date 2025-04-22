import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/simulation_controller.dart';

class LoanInputForm extends StatelessWidget {
  final TextEditingController loanAmountController;
  final TextEditingController loanTermController;
  final TextEditingController interestRateController;

  const LoanInputForm({
    super.key,
    required this.loanAmountController,
    required this.loanTermController,
    required this.interestRateController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimulationController());
    return Column(
      children: [
        Obx(() => TextField(
              controller: controller.loanAmountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                MoneyInputFormatter(
                  thousandSeparator: ThousandSeparator.Period,
                  mantissaLength: 0,
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Jumlah Pinjaman',
                prefixText: 'Rp ',
                errorText: controller.isLoanAmountValid.value
                    ? null
                    : 'Minimal Rp 5.000.000',
                border: const OutlineInputBorder(),
              ),
            )),
        const SizedBox(height: 12),
        TextField(
          controller: loanTermController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'Lama Peminjaman (bulan)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: interestRateController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Bunga/Tahun (%)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
