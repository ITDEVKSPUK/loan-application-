import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loan_apllication/views/employee/Simulation_Calculator/logic_calculator.dart';

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
    final double loanAmount = double.parse(_loanAmountController.text);
    final int loanTerm = int.parse(_loanTermController.text);
    final double annualInterestRate =
        double.parse(_interestRateController.text) / 100;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulasi Kredit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _loanAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Pinjaman',
                prefixText: 'Rp ',
              ),
            ),
            TextField(
              controller: _loanTermController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Lama Peminjaman (bulan)',
              ),
            ),
            TextField(
              controller: _interestRateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Bunga/Tahun (%)',
              ),
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
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _startDate) {
                  setState(() {
                    _startDate = picked;
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: _calculateLoan,
              child: const Text('Kalkulasi'),
            ),
            const SizedBox(height: 20),
            if (_monthlyPayment > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Angsuran: Rp ${_monthlyPayment.toStringAsFixed(2)}'),
                  Text('Total Bunga: Rp ${_totalInterest.toStringAsFixed(2)}'),
                  Text(
                      'Total yang Dibayarkan: Rp ${_totalPayment.toStringAsFixed(2)}'),
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
                      rows: _repaymentSchedule.map((schedule) {
                        return DataRow(cells: [
                          DataCell(Text(schedule['month'].toString())),
                          DataCell(Text(
                              'Rp ${schedule['totalPayment'].toStringAsFixed(2)}')),
                          DataCell(Text(
                              'Rp ${schedule['interestPayment'].toStringAsFixed(2)}')),
                          DataCell(Text(
                              'Rp ${schedule['principalPayment'].toStringAsFixed(2)}')),
                          DataCell(Text(
                              'Rp ${schedule['remainingBalance'].toStringAsFixed(2)}')),
                        ]);
                      }).toList(),
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
