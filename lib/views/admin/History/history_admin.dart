import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';

class HistoryAdmin extends StatelessWidget {
  const HistoryAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Center(
        child: Text('History'),
      ),
    );
  }
}
