class LoanSimulationResponse {
  final String loanAmount;
  final String annualInterestRate;
  final String loanDate;
  final String paymentFrequency;
  final String tenor;
  final String method;
  final String firstPaymentDue;
  final String lastPaymentDue;
  final String totalAllPayments;
  final String monthlyPayment;
  final String totalInterest;
  final String totalPayment;
  final List<RepaymentData> data;

  LoanSimulationResponse({
    required this.loanAmount,
    required this.annualInterestRate,
    required this.loanDate,
    required this.paymentFrequency,
    required this.tenor,
    required this.method,
    required this.firstPaymentDue,
    required this.lastPaymentDue,
    required this.totalAllPayments,
    required this.data,
    required this.monthlyPayment,
    required this.totalInterest,
    required this.totalPayment,
  });

  factory LoanSimulationResponse.fromJson(Map<String, dynamic> json) {
    return LoanSimulationResponse(
      loanAmount: json['Loan Amount'] ?? '0',
      annualInterestRate: json['Annual Interest Rate'] ?? '0',
      loanDate: json['Loan Date'],
      paymentFrequency: json['Payment Frequency'] ?? '',
      tenor: json['Tenor'] ?? '',
      method: json['Method'] ?? '',
      firstPaymentDue: json['1st Payment Due'],
      lastPaymentDue: json['Last Payment Due'] ?? 'raono',
      totalAllPayments: json['Total All Payments']?.toString() ?? '0',
      data: (json['data'] as List<dynamic>)
          .map((e) => RepaymentData.fromJson(e))
          .toList(),
      monthlyPayment: json['Monthly Payment']?.toString() ?? '0',
      totalInterest: json['Total Interest']?.toString() ?? '0',
      totalPayment: json['Total Payment']?.toString() ?? '0',
    );
  }
}

class RepaymentData {
  final DateTime month;
  final String monthSay;
  final String balance;
  final String interest;
  final String principal;
  final String payment;

  RepaymentData({
    required this.month,
    required this.monthSay,
    required this.balance,
    required this.interest,
    required this.principal,
    required this.payment,
  });

  factory RepaymentData.fromJson(Map<String, dynamic> json) {
    return RepaymentData(
      month: DateTime.parse(json['Month']),
      monthSay: json['MonthSay'] ?? '',
      balance: json['Balance'].toString() ?? "0",
      interest: json['Interest'].toString() ?? "0",
      principal: json['Principal'].toString() ?? "0",
      payment: json['Payment'].toString() ?? "0",
    );
  }
}
