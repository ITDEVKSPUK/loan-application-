import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/views/admin/Home/home_controller.dart';
import 'package:loan_apllication/widgets/survey_box.dart';

class Home extends StatelessWidget {
  final SurveyController controller = Get.put(SurveyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 57,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Text(
                'Survey List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: controller.surveyList.length,
                  itemBuilder: (context, index) {
                    final item = controller.surveyList[index];
                    return SurveyBox(
                      name: item['name']!,
                      date: item['date']!,
                      location: item['location']!,
                      status: item['status']!,
                      image: item['image']!,
                      statusColor: controller.getStatusColor(item['status']!),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
