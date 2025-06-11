import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/Simulation_Calculator/simulation_controller.dart';

class LoanTypeDropdown extends StatelessWidget {
  const LoanTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<SimulationController>();
    return Obx(() => DropdownButtonFormField<String>(
      value: ctrl.loanType.value,
      decoration: const InputDecoration(labelText: 'Metode', border: OutlineInputBorder()),
      items: ['FLAT','ANNUITY','EFFECTIVE'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (val) {
        if (val != null) ctrl.loanType.value = val;
      },
    ));
  }
}
