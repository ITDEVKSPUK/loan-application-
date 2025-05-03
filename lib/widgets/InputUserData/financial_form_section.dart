import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/inputuserdata/form_agunan_controller.dart';
import 'package:loan_application/widgets/InputUserData/textfield_form.dart';

class FinancialFormSection extends StatelessWidget {
  final CreditFormController controller;

  const FinancialFormSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextfieldForm(
          label: 'Jumlah yang akan dipinjam',
          hintText: 'Masukkan jumlah pinjaman',
          controller: controller.plafondController,
          keyboardType: TextInputType.number,
         inputFormatters: [MoneyInputFormatter()],

        ),
        const SizedBox(height: 16),
        TextfieldForm(
          label: 'Deskripsi Jaminan',
          hintText: 'Contoh: BPKB',
          controller: controller.collateralDescriptionController,
        ),
        TextfieldForm(
          label: 'Nilai Jaminan',
          hintText: 'Masukkan nilai jaminan',
          controller: controller.collateralValueController,
          keyboardType: TextInputType.number,
        inputFormatters: [MoneyInputFormatter()],

        ),
        const SizedBox(height: 24),
        const Text(
          "📊 Info Keuangan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextfieldForm(
          label: 'Pendapatan per bulan',
          controller: controller.incomeController,
          keyboardType: TextInputType.number,
         inputFormatters: [MoneyInputFormatter()],

        ),
        TextfieldForm(
          label: 'Total Aset',
          controller: controller.assetController,
          keyboardType: TextInputType.number,
         inputFormatters: [MoneyInputFormatter()],

        ),
        TextfieldForm(
          label: 'Pengeluaran per bulan',
          controller: controller.expensesController,
          keyboardType: TextInputType.number,
         inputFormatters: [MoneyInputFormatter()],
        ),
        TextfieldForm(
          label: 'Angsuran per bulan',
          controller: controller.installmentController,
          keyboardType: TextInputType.number,
         inputFormatters: [MoneyInputFormatter()],

        ),
      ],
    );
  }
}
