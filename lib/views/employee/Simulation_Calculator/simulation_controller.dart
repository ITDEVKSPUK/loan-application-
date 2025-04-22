import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/logic_calculator.dart';

class SimulationController extends GetxController {
  final loanAmountController = TextEditingController();
  final loanTermController = TextEditingController();
  final interestRateController = TextEditingController();

  var loanType = 'Flat'.obs;
  var startDate = DateTime.now().obs;

  var monthlyPayment = 0.0.obs;
  var totalInterest = 0.0.obs;
  var totalPayment = 0.0.obs;
  var repaymentSchedule = <Map<String, dynamic>>[].obs;
  var isLoanAmountValid = true.obs;

  void validateLoanAmount() {
    final rawText = loanAmountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = int.tryParse(rawText) ?? 0;
    isLoanAmountValid.value = amount >= 5000000;
  }

  void calculateLoan(BuildContext context) {
    validateLoanAmount();

    if (!isLoanAmountValid.value) {
      _showError(context, 'Jumlah pinjaman minimal Rp 5.000.000');
      return;
    }

    final amountText = loanAmountController.text;
    final termText = loanTermController.text;
    final rateText = interestRateController.text;

    if (amountText.isEmpty || termText.isEmpty || rateText.isEmpty) {
      _showError(context, 'Semua input harus diisi');
      return;
    }

    try {
      final cleanedAmount = amountText.replaceAll(RegExp(r'[^0-9]'), '');

      final cleanedTerm = termText.replaceAll('.', '').replaceAll(',', '');
      final cleanedRate = rateText.replaceAll(',', '.');

      final double loanAmount = double.parse(cleanedAmount);
      final int loanTerm = int.parse(cleanedTerm);
      final double interestRate = double.parse(cleanedRate) / 100;

      if (loanAmount <= 0 || loanTerm <= 0 || interestRate <= 0) {
        _showError(context, 'Nilai input harus lebih dari 0');
        return;
      }

      final result = LoanCalculator.calculateLoan(
        loanAmount: loanAmount,
        loanTerm: loanTerm,
        annualInterestRate: interestRate,
        loanType: loanType.value,
      );

      monthlyPayment.value = result['monthlyPayment'];
      totalInterest.value = result['totalInterest'];
      totalPayment.value = result['totalPayment'];
      repaymentSchedule.value =
          List<Map<String, dynamic>>.from(result['repaymentSchedule']);
    } catch (e) {
      _showError(context, 'Format input tidak valid');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void onClose() {
    loanAmountController.dispose();
    loanTermController.dispose();
    interestRateController.dispose();
    super.onClose();
  }
}
