import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/service/post_simulation_credit.dart';
import 'package:loan_application/API/models/calculator_models.dart';

class SimulationController extends GetxController {
  final loanAmountController = TextEditingController();
  final loanTermController = TextEditingController();
  final interestRateController = TextEditingController();

  var loanType = 'FLAT'.obs;
  var startDate = DateTime.now().obs;

  var isLoanAmountValid = true.obs;
  var isLoading = false.obs;

  var response = Rxn<LoanSimulationResponse>();
  RxList<Map<String, dynamic>> repaymentSchedule = <Map<String, dynamic>>[].obs;

  var monthlyPayment = 0.0.obs;
  var totalInterest = 0.0.obs;
  var totalPayment = 0.0.obs;

  // void validateLoanAmount(String val) {
  //   final cleaned = val.replaceAll('.', '').replaceAll('Rp', '').trim();
  //   final num = int.tryParse(cleaned) ?? 0;
  //   isLoanAmountValid.value = num >= 5000000;
  // }

  void validateLoanAmount(String val) {
    final cleaned = val.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = int.tryParse(cleaned) ?? 0;

    isLoanAmountValid.value = amount >= 5000000;

    print('Parsed amount: $amount');
    print('Is valid: ${isLoanAmountValid.value}');
  }

  Future<void> calculateLoan(BuildContext context) async {
    if (!isLoanAmountValid.value) {
      _showError(context, 'Minimal pinjaman Rp 5.000.000');
      return;
    }
    if (loanAmountController.text.isEmpty ||
        loanTermController.text.isEmpty ||
        interestRateController.text.isEmpty) {
      _showError(context, 'Lengkapi semua input');
      return;
    }
    try {
      final cleanedLoanAmount =
          loanAmountController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final loanAmount = double.tryParse(cleanedLoanAmount) ?? 0.0;

      final tenor = int.tryParse(loanTermController.text) ?? 0;
      final rate =
          double.tryParse(interestRateController.text.replaceAll(',', '.')) ??
              0.0;

      if (loanAmount <= 0 || tenor <= 0 || rate <= 0) {
        _showError(
            context, 'Input tidak valid. Harap isi semua data dengan benar.');
        return;
      }

      isLoading.value = true;
      final res = await SimulationService().simulateLoan(
        method: loanType.value,
        loanDate: DateTime.now(),
        interestRate: rate.toString(),
        loanAmount: loanAmount.toString(),
        tenor: tenor.toString(),
      );
      if (res == null) {
        _showError(context, 'Gagal mendapatkan data simulasi');
        return;
      }
      response.value = res;

      monthlyPayment.value = double.tryParse(res.monthlyPayment) ?? 0;
      totalInterest.value = double.tryParse(res.totalInterest) ?? 0;
      totalPayment.value = double.tryParse(res.totalPayment) ?? 0;
      repaymentSchedule.value = res.data
          .map((e) => {
                'month': e.monthSay,
                'totalPayment': e.payment,
                'interestPayment': e.interest,
                'principalPayment': e.principal,
                'remainingBalance': e.balance,
              })
          .toList();

      // Get.to(() => LoanSummaryAndSchedule(
      //   monthlyPayment: monthlyPayment.value,
      //   totalInterest: totalInterest.value,
      //   totalPayment: totalPayment.value,
      //   loanAmountText: loanAmountController.text,
      //   loanTermText: loanTermController.text,
      //   loanType: loanType.value,
      //   interestRateText: interestRateController.text,
      //   startDate: startDate.value,
      //   repaymentSchedule: repaymentSchedule,
      // ));
    } catch (e) {
      _showError(context, 'Error saat kalkulasi');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(BuildContext ctx, String msg) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void onClose() {
    loanAmountController.dispose();
    loanTermController.dispose();
    interestRateController.dispose();
    super.onClose();
  }
}
