import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
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
          width: double.infinity,
          height: 50,
          label: 'Jumlah yang akan dipinjam',
          hintText: 'Masukkan jumlah pinjaman',
          controller: controller.plafondController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Tujuan Pinjaman',
          hintText: 'Contoh: Modal Kerja',
          controller: controller.purposeController,
        ),
        const SizedBox(height: 16),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Taksiran Nilai Jaminan',
          hintText: 'Masukkan nilai jaminan',
          controller: controller.collateralValueController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "Info Keuangan",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Pendapatan per bulan',
          controller: controller.incomeController,
          keyboardType: TextInputType.number,
           inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Total Aset',
          controller: controller.assetController,
          keyboardType: TextInputType.number,
           inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Pengeluaran per bulan',
          controller: controller.expensesController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
        TextfieldForm(
          width: double.infinity,
          height: 50,
          label: 'Angsuran per bulan',
          controller: controller.installmentController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            MoneyInputFormatter(
              thousandSeparator: ThousandSeparator.Period,
              mantissaLength: 0, // Prevent decimal input
            ),
          ],
        ),
      ],
    );
  }
}