import 'package:flutter/material.dart';
import 'package:loan_apllication/widgets/custom_appbar.dart';

class InputData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Input User Data'),
      body: Center(
        child: Text('Input Data Form Goes Here'),
      ),
    );
  }
}
