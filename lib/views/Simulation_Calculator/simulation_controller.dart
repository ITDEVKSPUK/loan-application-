import 'package:awesome_dialog/awesome_dialog.dart';
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
  var LoanAmount = ''.obs;
  var isLoanAmountValid = true.obs;
  var isLoading = false.obs;
  var duration = ''.obs;
  var annualInterestRate = ''.obs;

  var response = Rxn<LoanSimulationResponse>();
  RxList<Map<String, dynamic>> repaymentSchedule = <Map<String, dynamic>>[].obs;

  var monthlyPayment = 0.0.obs;
  var totalInterest = 0.0.obs;
  var totalPayment = 0.0.obs;
  var loanDate = ''.obs;
  var firstPaymentDue = ''.obs;
  var lastPaymentDue = ''.obs;
  var method = ''.obs;

  // void validateLoanAmount(String val) {
  //   final cleaned = val.replaceAll('.', '').replaceAll('Rp', '').trim();
  //   final num = int.tryParse(cleaned) ?? 0;
  //   isLoanAmountValid.value = num >= 5000000;
  // }

  // void validateLoanAmount(String val) {
  //   final cleaned = val.replaceAll(RegExp(r'[^0-9]'), '');
  //   final amount = int.tryParse(cleaned) ?? 0;

  //   isLoanAmountValid.value = amount >= 5000000;

  //   print('Parsed amount: $amount');
  //   print('Is valid: ${isLoanAmountValid.value}');
  // }
Future<void> calculateLoan(BuildContext context) async {
  if (loanAmountController.text.isEmpty ||
      loanTermController.text.isEmpty ||
      interestRateController.text.isEmpty) {
    _showAwesomeError(context, 'Lengkapi semua input');
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
      _showAwesomeError(
          context, 'Input tidak valid. Harap isi semua data dengan benar.');
      return;
    }

    String roundTo = (loanType.value == 'FLAT') ? '2' : '1';

    isLoading.value = true;
    final res = await SimulationService().simulateLoan(
      method: loanType.value,
      loanDate: startDate.value,
      interestRate: rate.toString(),
      loanAmount: loanAmount.toString(),
      tenor: tenor.toString(),
      roundTo: roundTo,
    );

    if (res == null) {
      _showAwesomeError(context, 'Gagal mendapatkan data simulasi');
      return;
    }

    response.value = res;

    monthlyPayment.value = double.tryParse(res.monthlyPayment) ?? 0;
    totalInterest.value = double.tryParse(res.totalInterest) ?? 0;
    totalPayment.value = double.tryParse(res.totalPayment) ?? 0;
    lastPaymentDue.value = res.lastPaymentDue;
    firstPaymentDue.value = res.firstPaymentDue;
    loanDate.value = res.loanDate;
    LoanAmount.value = res.loanAmount;
    duration.value = res.tenor;
    annualInterestRate.value = res.annualInterestRate;
    method.value = res.method;
    repaymentSchedule.value = res.data
        .map((e) => {
              'month': e.monthSay,
              'totalPayment': e.payment,
              'interestPayment': e.interest,
              'principalPayment': e.principal,
              'remainingBalance': e.balance,
            })
        .toList();

    // Tampilkan dialog sukses
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.scale,
      title: 'Berhasil',
      desc: 'Simulasi berhasil dihitung!',
      btnOkOnPress: () {},
    ).show();

  } catch (e) {
    _showAwesomeError(context, 'Error saat kalkulasi');
  } finally {
    isLoading.value = false;
  }
}

// helper untuk error
void _showAwesomeError(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.leftSlide,
    title: 'Gagal',
    desc: message,
    btnOkOnPress: () {},
  ).show();
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
