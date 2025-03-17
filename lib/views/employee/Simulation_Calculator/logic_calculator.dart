import 'dart:math' as math;

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

    switch (loanType) {
      case 'Flat':
        monthlyPayment = (loanAmount + (loanAmount * annualInterestRate * loanTerm / 12)) / loanTerm;
        totalInterest = loanAmount * annualInterestRate * loanTerm / 12;
        totalPayment = loanAmount + totalInterest;
        for (int i = 0; i < loanTerm; i++) {
          double interestPayment = loanAmount * monthlyInterestRate;
          double principalPayment = monthlyPayment - interestPayment;
          loanAmount -= principalPayment;
          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': monthlyPayment,
            'interestPayment': interestPayment,
            'principalPayment': principalPayment,
            'remainingBalance': loanAmount,
          });
        }
        break;
      case 'Efektif':
        monthlyPayment = loanAmount * monthlyInterestRate / (1 - (1 / math.pow((1 + monthlyInterestRate), loanTerm)));
        totalInterest = monthlyPayment * loanTerm - loanAmount;
        totalPayment = monthlyPayment * loanTerm;
        for (int i = 0; i < loanTerm; i++) {
          double interestPayment = loanAmount * monthlyInterestRate;
          double principalPayment = monthlyPayment - interestPayment;
          loanAmount -= principalPayment;
          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': monthlyPayment,
            'interestPayment': interestPayment,
            'principalPayment': principalPayment,
            'remainingBalance': loanAmount,
          });
        }
        break;
      case 'Anuitas':
      default:
        monthlyPayment = loanAmount * monthlyInterestRate / (1 - (1 / math.pow((1 + monthlyInterestRate), loanTerm)));
        totalInterest = monthlyPayment * loanTerm - loanAmount;
        totalPayment = monthlyPayment * loanTerm;
        for (int i = 0; i < loanTerm; i++) {
          double interestPayment = loanAmount * monthlyInterestRate;
          double principalPayment = monthlyPayment - interestPayment;
          loanAmount -= principalPayment;
          repaymentSchedule.add({
            'month': i + 1,
            'totalPayment': monthlyPayment,
            'interestPayment': interestPayment,
            'principalPayment': principalPayment,
            'remainingBalance': loanAmount,
          });
        }
        break;
    }

    return {
      'monthlyPayment': monthlyPayment,
      'totalInterest': totalInterest,
      'totalPayment': totalPayment,
      'repaymentSchedule': repaymentSchedule,
    };
  }
}