import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanTypeDropdown extends StatelessWidget {
  final RxString loanType;

  const LoanTypeDropdown({super.key, required this.loanType});

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButtonFormField<String>(
          value: loanType.value,
          items: ['Flat', 'Efektif', 'Anuitas']
              .map((type) => DropdownMenuItem(value: type, child: Text(type)))
              .toList(),
          onChanged: (val) => loanType.value = val!,
          decoration: const InputDecoration(
            labelText: 'Jenis Pinjaman',
            border: OutlineInputBorder(),
          ),
        ));
  }
}
