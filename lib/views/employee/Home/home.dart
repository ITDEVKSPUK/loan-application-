import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/views/employee/Home/home_controller.dart';
import 'package:loan_apllication/views/employee/inputuserdata/inputdata.dart';
import 'package:loan_apllication/widgets/survey_box.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.all(13.0),
          child: GestureDetector(
            onTap: () {
              Get.to(() => InputData());
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 73, 130),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
