  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';

  class LoanStartDatePicker extends StatelessWidget {
    final Rx<DateTime> startDate;

    const LoanStartDatePicker({super.key, required this.startDate});

    @override
    Widget build(BuildContext context) {
      return Obx(() => ListTile(
            title: const Text('Mulai Meminjam'),
            subtitle: Text(DateFormat.yMMMMd().format(startDate.value)),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: startDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (picked != null) startDate.value = picked;
            },
          ));
    }
  }
