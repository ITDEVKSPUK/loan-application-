import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';
import 'package:loan_application/widgets/InputUserData/gender_radio.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_bukti.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_loan.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_type.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class SurveyDetail extends StatefulWidget {
  @override
  _SurveyDetailState createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Detail',
        onBack: () => Get.offAllNamed('/dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto KTP
            Center(
              child: Container(
                width: 317,
                height: 198.02,
                child: Opacity(
                  opacity: 0.53,
                  child: Image.asset(
                    'assets/images/rawktp.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Data Pribadi
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldReadonly(
                      label: 'NIK',
                      width: double.infinity,
                      height: 50,
                      controller:
                          TextEditingController(text: controller.nik.value),
                      keyboardType: TextInputType.number,
                    ),
                    FieldReadonly(
                      label: 'Nama',
                      width: double.infinity,
                      height: 50,
                      controller:
                          TextEditingController(text: controller.name.value),
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'No. Telpon',
                      width: double.infinity,
                      height: 50,
                      controller: TextEditingController(
                          text: controller.phoneNumber.value),
                      keyboardType: TextInputType.phone,
                    ),
                    FieldReadonly(
                      label: 'Alamat Lengkap',
                      width: double.infinity,
                      height: 50,
                      controller: TextEditingController(
                          text: controller.address.value),
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'Pekerjaan',
                      width: double.infinity,
                      height: 50,
                      controller: TextEditingController(
                          text: controller.occupation.value),
                      keyboardType: TextInputType.text,
                    ),
                  ],
                )),

            // Data Pinjaman & Jaminan
            LoanAmountWidget(),
            CollateralTypeWidget(),
            CollateralProofWidget(),
          ],
        ),
      ),
      )
    );
  }
}
