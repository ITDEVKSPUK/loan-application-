import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanSummaryAndSchedule extends StatelessWidget {
  final double monthlyPayment;
  final double totalInterest;
  final double totalPayment;
  final String loanAmountText;
  final String loanTermText;
  final String loanType;
  final String interestRateText;
  final DateTime startDate;
  final String firstPaymentDue;
  final String lastPaymentDue;
  final String duration;
  final String annualInterestRate;
  final String method;
  final String loanDate;
  final List<Map<String, dynamic>> repaymentSchedule;

  const LoanSummaryAndSchedule({
    super.key,
    required this.monthlyPayment,
    required this.totalInterest,
    required this.totalPayment,
    required this.loanAmountText,
    required this.loanTermText,
    required this.loanType,
    required this.interestRateText,
    required this.startDate,
    required this.repaymentSchedule,
    required this.lastPaymentDue,
    required this.loanDate,
    required this.firstPaymentDue,
    required this.duration,
    required this.annualInterestRate,
    required this.method,
  });

  String formatCurrency(dynamic value) {
    print('Input to formatCurrency: $value, Type: ${value.runtimeType}');
    double number;
    if (value is String) {
      number = double.tryParse(value.replaceAll(',', '')) ?? 0;
    } else if (value is num) {
      number = value.toDouble();
    } else {
      number = 0;
    }
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(number);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrincipal = 0;
    double totalInterestLocal = 0;
    double totalPaymentLocal = 0;

    for (var schedule in repaymentSchedule) {
      totalPrincipal +=
          double.tryParse(schedule['principalPayment'].toString()) ?? 0;
      totalInterestLocal +=
          double.tryParse(schedule['interestPayment'].toString()) ?? 0;
      totalPaymentLocal +=
          double.tryParse(schedule['totalPayment'].toString()) ?? 0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Jumlah Pinjaman: ${formatCurrency(loanAmountText)}'),
        Text('Lama Peminjaman: $duration'),
        Text('Jenis: $method'),
        Text('Bunga per tahun: $annualInterestRate'),
        Text(
            'Tanggal peminjaman: ${DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(loanDate))}'),
        Text(
            'Pembayaran Pertama: ${DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(firstPaymentDue))}'),
        const SizedBox(height: 20),
        Text('Total yang Dibayarkan: ${formatCurrency(totalPaymentLocal)}'),
        Text(
          'Tanggal Lunas: ${DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(lastPaymentDue))}',
        ),
        const SizedBox(height: 20),
        const Text('Simulasi Angsuran:'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Angsuran ke-')),
              DataColumn(label: Text('Total Angsuran')),
              DataColumn(label: Text('Angsuran Bunga')),
              DataColumn(label: Text('Angsuran Pokok')),
              DataColumn(label: Text('Saldo Pinjaman')),
            ],
            rows: [
              ...repaymentSchedule.map((schedule) {
                return DataRow(cells: [
                  DataCell(Text(schedule['month'].toString())),
                  DataCell(Text(formatCurrency(schedule['totalPayment']))),
                  DataCell(Text(formatCurrency(schedule['interestPayment']))),
                  DataCell(Text(formatCurrency(schedule['principalPayment']))),
                  DataCell(Text(formatCurrency(schedule['remainingBalance']))),
                ]);
              }),
              DataRow(cells: [
                const DataCell(Text('Total')),
                DataCell(Text(formatCurrency(totalPaymentLocal))),
                DataCell(Text(formatCurrency(totalInterestLocal))),
                DataCell(Text(formatCurrency(totalPrincipal))),
                const DataCell(Text('')),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
