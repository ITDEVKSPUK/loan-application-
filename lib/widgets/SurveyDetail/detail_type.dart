import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/views/SurveyDetail/detail_controller.dart';

class CollateralTypeWidget extends StatelessWidget {
  final DetailController controller = Get.find<DetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      height: 60,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 0,
            child: Text(
              'Jenis Jaminan',
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
            top: 30,
            child: Obx(() => Text(
              controller.collateralType.value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
              ),
            )),
          ),
        ],
      ),
    );
  }
}
