import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/logic_calculator.dart';
import 'package:loan_apllication/widgets/app_button.dart';

class Simulation_Employe extends StatefulWidget {
  const Simulation_Employe({super.key});

  @override
  _Simulation_EmployeState createState() => _Simulation_EmployeState();
}

class _Simulation_EmployeState extends State<Simulation_Employe> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  DateTime _startDate = DateTime.now();
  double _monthlyPayment = 0.0;
  double _totalInterest = 0.0;
  double _totalPayment = 0.0;
  String _loanType = 'Anuitas';
  List<Map<String, dynamic>> _repaymentSchedule = [];

  void _calculateLoan() {
    if (_loanAmountController.text.isEmpty ||
        _loanTermController.text.isEmpty ||
        _interestRateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua input harus diisi'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final double loanAmount = NumberFormat.decimalPattern()
        .parse(_loanAmountController.text)
        .toDouble();
    final int loanTerm = int.parse(_loanTermController.text);
    final double annualInterestRate = NumberFormat.decimalPattern()
            .parse(_interestRateController.text)
            .toDouble() /
        100;

    final result = LoanCalculator.calculateLoan(
      loanAmount: loanAmount,
      loanTerm: loanTerm,
      annualInterestRate: annualInterestRate,
      loanType: _loanType,
    );

    setState(() {
      _monthlyPayment = result['monthlyPayment'];
      _totalInterest = result['totalInterest'];
      _totalPayment = result['totalPayment'];
      _repaymentSchedule = result['repaymentSchedule'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrincipal = 0;
    double totalInterest = 0;
    double totalPayment = 0;

    for (var schedule in _repaymentSchedule) {
      totalPrincipal += schedule['principalPayment'];
      totalInterest += schedule['interestPayment'];
      totalPayment += schedule['totalPayment'];
    }

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        title: Center(
          child: const Text(
            'Simulasi Kredittt',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loanAmountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Jumlah Pinjaman',
                prefixText: 'Rp ',
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _loanAmountController,
              builder: (context, value, child) {
                String amount = value.text.isEmpty ? '0' : value.text;
                try {
                  return Text(
                    'Jumlah Pinjaman: Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(amount))}',
                  );
                } catch (e) {
                  return Text('Jumlah Pinjaman: Rp 0');
                }
              },
            ),
            TextField(
              controller: _loanTermController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Lama Peminjaman (bulan)',
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _loanTermController,
              builder: (context, value, child) {
                String months = value.text.isEmpty ? '0' : value.text;
                double years = double.tryParse(months) ?? 0 / 12;
                return Text(
                  'Lama Peminjaman: $months bulan (${(years / 12).toStringAsFixed(1)} tahun)',
                );
              },
            ),
            TextField(
              controller: _interestRateController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Bunga/Tahun (%)',
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _interestRateController,
              builder: (context, value, child) {
                String rate = value.text.isEmpty ? '0' : value.text;
                try {
                  double annualRate =
                      NumberFormat.decimalPattern().parse(rate).toDouble();
                  return Text(
                      'Bunga/Bulan: ${(annualRate / 12).toStringAsFixed(2)}%');
                } catch (e) {
                  return Text('Bunga/Bulan: 0%');
                }
              },
            ),
            DropdownButton<String>(
              value: _loanType,
              onChanged: (String? newValue) {
                setState(() {
                  _loanType = newValue!;
                });
              },
              items: <String>['Flat', 'Efektif', 'Anuitas']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ListTile(
              title: const Text('Mulai Meminjam'),
              subtitle: Text(DateFormat.yMMMMd().format(_startDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _startDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _startDate) {
                  setState(() {
                    _startDate = picked;
                  });
                }
              },
            ),
            CustomButton(
              paddingHorizontal: BorderSide.strokeAlignCenter,
              paddingVertical: BorderSide.strokeAlignCenter,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onPressed: _calculateLoan,
              text: 'Hitung',
              color: AppColors.deepBlue,
              borderRadius: 8,
            ),
            const SizedBox(height: 20),
            if (_monthlyPayment > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Jumlah Pinjaman: Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(_loanAmountController.text))}'),
                  Text('Lama Peminjaman: ${_loanTermController.text} bulan'),
                  Text('Jenis: $_loanType'),
                  Text(
                      'Bunga per bulan: ${(NumberFormat.decimalPattern().parse(_interestRateController.text) / 12).toStringAsFixed(2)}%'),
                  Text('Bunga per tahun: ${_interestRateController.text}%'),
                  Text(
                      'Mulai Meminjam: ${DateFormat.yMMMMd().format(_startDate)}'),
                  const SizedBox(height: 20),
                  Text(
                      'Angsuran per bulan: Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(_monthlyPayment.toStringAsFixed(2)))}'),
                  Text(
                      'Total Bunga: Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(_totalInterest.toStringAsFixed(2)))}'),
                  Text(
                      'Total yang Dibayarkan: Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(_totalPayment.toStringAsFixed(2)))}'),
                  Text(
                      'Tanggal Lunas: ${DateFormat.yMMMMd().format(_startDate.add(Duration(days: 30 * int.parse(_loanTermController.text))))}'),
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
                        ..._repaymentSchedule.map((schedule) {
                          return DataRow(cells: [
                            DataCell(Text(schedule['month'].toString())),
                            DataCell(Text(
                                'Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(schedule['totalPayment'].toStringAsFixed(2)))}')),
                            DataCell(Text(
                                'Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(schedule['interestPayment'].toStringAsFixed(2)))}')),
                            DataCell(Text(
                                'Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(schedule['principalPayment'].toStringAsFixed(2)))}')),
                            DataCell(Text(
                                'Rp ${NumberFormat.decimalPattern().format(NumberFormat.decimalPattern().parse(schedule['remainingBalance'].toStringAsFixed(2)))}')),
                          ]);
                        }).toList(),
                        DataRow(cells: [
                          const DataCell(Text('Total')),
                          DataCell(Text(
                              'Rp ${NumberFormat.decimalPattern().format(totalPayment)}')),
                          DataCell(Text(
                              'Rp ${NumberFormat.decimalPattern().format(totalInterest)}')),
                          DataCell(Text(
                              'Rp ${NumberFormat.decimalPattern().format(totalPrincipal)}')),
                          const DataCell(Text('')),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

