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
  });

  String formatCurrency(dynamic value) {
    double number;
    if (value is String) {
      final cleaned = value.replaceAll('.', '').replaceAll(',', '');
      number = double.tryParse(cleaned) ?? 0;
    } else if (value is num) {
      number = value.toDouble();
    } else {
      number = 0;
    }

    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(number);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrincipal = 0;
    double totalInterestLocal = 0;
    double totalPaymentLocal = 0;

    for (var schedule in repaymentSchedule) {
      totalPrincipal += schedule['principalPayment'];
      totalInterestLocal += schedule['interestPayment'];
      totalPaymentLocal += schedule['totalPayment'];
    }

    final double bungaPerBulan = (double.tryParse(interestRateText.replaceAll(',', '.')) ?? 0) / 12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Jumlah Pinjaman: ${formatCurrency(loanAmountText)}'),
        Text('Lama Peminjaman: $loanTermText bulan'),
        Text('Jenis: $loanType'),
        Text('Bunga per bulan: ${bungaPerBulan.toStringAsFixed(2)}%'),
        Text('Bunga per tahun: $interestRateText%'),
        Text('Mulai Meminjam: ${DateFormat.yMMMMd().format(startDate)}'),
        const SizedBox(height: 20),
        Text('Angsuran per bulan: ${formatCurrency(monthlyPayment)}'),
        Text('Total Bunga: ${formatCurrency(totalInterest)}'),
        Text('Total yang Dibayarkan: ${formatCurrency(totalPayment)}'),
        Text(
          'Tanggal Lunas: ${DateFormat.yMMMMd().format(startDate.add(Duration(days: 30 * int.parse(loanTermText))))}',
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
              }).toList(),
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
