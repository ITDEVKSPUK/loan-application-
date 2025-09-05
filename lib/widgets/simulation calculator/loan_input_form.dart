import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:loan_application/views/Simulation_Calculator/simulation_controller.dart';

class LoanInputForm extends StatelessWidget {
  const LoanInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SimulationController>();
    return Column(
      children: [
        TextField(
          controller: ctrl.loanAmountController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // tidak ada desimal
            ),
          ],
          decoration: InputDecoration(
            labelText: 'Jumlah Pinjaman',
            prefixText: 'Rp ',
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: ctrl.loanTermController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              labelText: 'Tenor (bulan)', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: ctrl.interestRateController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
              labelText: 'Bunga/Tahun (%)', border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
