import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';

class LoanAmountWidget extends StatelessWidget {
  final controller = Get.find<DetailController>();

   LoanAmountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: 317,
          height: 45,
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                top: 0,
                child: Text(
                  'Nominal Peminjaman',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 25,
                child: Text(
                  controller.loanAmount.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
