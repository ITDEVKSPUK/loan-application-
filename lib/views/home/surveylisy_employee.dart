import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/home/home_controller.dart';
import 'package:loan_application/widgets/survey_box.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({super.key});

  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getHistory(); // Fetch dynamic history list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
            child: const Center(
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
            child: Obx(() {
              final list = controller.surveyList;
              if (list.isEmpty) {
                return const Center(child: Text('No survey data available.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.surveyList.length,
                itemBuilder: (context, index) {
                  final item = controller.surveyList[index];
                  return SurveyBox(
                    name: item.fullName,
                    date: DateFormat('yyyy-MM-dd')
                        .format(item.application.trxDate),
                    location: item.sectorCity,
                    status: "UNREAD",
                    image: 'assets/images/bg.png',
                    statusColor: controller.getStatusColor("UNREAD"),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: GestureDetector(
            onTap: () => Get.toNamed(MyAppRoutes.inputDataScreen),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 4, 73, 130),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(Icons.add, color: Colors.white, size: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
