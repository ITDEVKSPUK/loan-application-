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

    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(number);
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

    final double bungaPerBulan =
        (double.tryParse(interestRateText.replaceAll(',', '.')) ?? 0) / 12;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📋 Ringkasan Pinjaman',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Jumlah Pinjaman', formatCurrency(loanAmountText)),
          _buildInfoRow('Lama Pinjaman', '$loanTermText bulan'),
          _buildInfoRow('Bunga per Tahun', '$interestRateText% / tahun'),
          _buildInfoRow(
              'Bunga per Bulan', '${bungaPerBulan.toStringAsFixed(2)}% / bulan'),
          _buildInfoRow('Jenis Perhitungan', loanType.toUpperCase()),
          _buildInfoRow('Mulai Meminjam',
              DateFormat.yMMMM().format(startDate)), // April 2025
          _buildInfoRow(
              'Tanggal Lunas',
              DateFormat.yMMMM()
                  .format(startDate.add(Duration(days: 30 * int.parse(loanTermText))))),

          const Divider(height: 32, thickness: 2),

          Text(
            '💰 Simulasi Pembayaran',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Angsuran per Bulan', formatCurrency(monthlyPayment)),
          _buildInfoRow('Total Bunga', formatCurrency(totalInterest)),
          _buildInfoRow('Total Pembayaran', formatCurrency(totalPayment)),

          const SizedBox(height: 24),
          Text(
            '📊 Tabel Rincian Angsuran',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
              columns: const [
                DataColumn(label: Text('Bulan')),
                DataColumn(label: Text('Total')),
                DataColumn(label: Text('Bunga')),
                DataColumn(label: Text('Pokok')),
                DataColumn(label: Text('Saldo')),
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
                  const DataCell(Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataCell(Text(formatCurrency(totalPaymentLocal))),
                  DataCell(Text(formatCurrency(totalInterestLocal))),
                  DataCell(Text(formatCurrency(totalPrincipal))),
                  const DataCell(Text('')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label)),
          const Text(':'),
          const SizedBox(width: 8),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
