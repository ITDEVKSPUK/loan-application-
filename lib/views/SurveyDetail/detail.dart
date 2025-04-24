import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_bukti.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_info.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_loan.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_type.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class SurveyDetail extends StatelessWidget {
  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Detail',
        onBack: () {
          Get.offAllNamed('/dashboard');
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 317,
              height: 198.02,
              child: Opacity(
                opacity: 0.53,
                child: Image.asset(
                  'assets/images/rawktp.png',
                  width: 317,
                  height: 198.02,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            PersonalInfoWidget(
              name: controller.name.value,
              phoneNumber: controller.phoneNumber.value,
              nik: controller.nik.value,
              address: controller.address.value,
              occupation: controller.occupation.value,
            ),
            LoanAmountWidget(),
            CollateralTypeWidget(),
            CollateralProofWidget(),
          ],
        ),
      ),
    );
  }
}
