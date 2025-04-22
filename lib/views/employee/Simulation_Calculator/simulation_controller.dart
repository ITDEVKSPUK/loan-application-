import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

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

  @override
  void onInit() {
    super.onInit();

    loanAmountController.addListener(() {
      validateLoanAmount();
    });
  }
}


class LoanCalculator {
  static Map<String, dynamic> calculateLoan({
    required double loanAmount,
    required int loanTerm,
    required double annualInterestRate,
    required String loanType,
  }) {
    final double monthlyInterestRate = annualInterestRate / 12;
    double monthlyPayment = 0.0;
    double totalInterest = 0.0;
    double totalPayment = 0.0;
    List<Map<String, dynamic>> repaymentSchedule = [];

    int roundUpToNearestHundred(int value) {
      return ((value + 99) ~/ 100) * 100;
    }

    switch (loanType) {
      case 'Flat':
        double monthlyPrincipal = loanAmount / loanTerm;
        double monthlyInterest = loanAmount * monthlyInterestRate;
        monthlyPayment = monthlyPrincipal + monthlyInterest;

        // ✅ Bulatkan ke atas kelipatan 100
        monthlyPayment =
            roundUpToNearestHundred(monthlyPayment.round()).toDouble();

        totalInterest = (monthlyPayment * loanTerm) - loanAmount;
        totalPayment = monthlyPayment * loanTerm;

        double remainingBalance = loanAmount;

        for (int i = 0; i < loanTerm; i++) {
          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': monthlyPayment,
            'interestPayment': monthlyInterest,
            'principalPayment': monthlyPayment - monthlyInterest,
            'remainingBalance':
                remainingBalance - (monthlyPayment - monthlyInterest) * (i + 1),
          });
        }
        break;

      case 'Efektif':
        double monthlyPrincipal = loanAmount / loanTerm;
        double remainingBalance = loanAmount;

        for (int i = 0; i < loanTerm; i++) {
          double interestPayment = remainingBalance * monthlyInterestRate;
          double totalMonthly = monthlyPrincipal + interestPayment;

          // Bulatkan ke atas ke 100
          totalMonthly =
              roundUpToNearestHundred(totalMonthly.round()).toDouble();

          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': totalMonthly,
            'interestPayment': interestPayment,
            'principalPayment': monthlyPrincipal,
            'remainingBalance': remainingBalance - monthlyPrincipal,
          });

          remainingBalance -= monthlyPrincipal;
          totalInterest += interestPayment;
          totalPayment += totalMonthly;
        }

        monthlyPayment = repaymentSchedule[0]['totalPayment'];
        break;

      case 'Anuitas':
        double remainingBalance = loanAmount;

        monthlyPayment = loanAmount *
            monthlyInterestRate /
            (1 - math.pow((1 + monthlyInterestRate), -loanTerm));

        // Bulatkan ke atas kelipatan 100
        monthlyPayment =
            roundUpToNearestHundred(monthlyPayment.round()).toDouble();

        for (int i = 0; i < loanTerm; i++) {
          double interestPayment = remainingBalance * monthlyInterestRate;
          double principalPayment = monthlyPayment - interestPayment;

          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': monthlyPayment,
            'interestPayment': interestPayment,
            'principalPayment': principalPayment,
            'remainingBalance': remainingBalance - principalPayment,
          });

          remainingBalance -= principalPayment;
          totalInterest += interestPayment;
          totalPayment += monthlyPayment;
        }

        break;

      default:
        throw Exception('Invalid loan type: $loanType');
    }

    return {
      'monthlyPayment': monthlyPayment,
      'totalInterest': totalInterest,
      'totalPayment': totalPayment,
      'repaymentSchedule': repaymentSchedule,
    };
  }
}
