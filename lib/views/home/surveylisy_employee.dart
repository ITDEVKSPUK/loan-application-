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
            child: Stack(
              children: [
                const Center(
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
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: Colors.black),
                        onPressed: () {
                          Get.toNamed(MyAppRoutes.notif);
                        },
                      ),
                      // Badge titik merah
                      Obx(() {
                        if (controller.notifCount == 0) return const SizedBox();
                        return Positioned(
                          right: 12,
                          top: 12,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.black,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await Future(() => controller.getHistory());
              },
              child: Obx(() {
                final list = controller.surveyList;
                if (list.isEmpty) {
                  return const Center(child: Text('No survey data available.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final statusText =
                        item.status?.value ?? item.application.toString();
                    final statusColor = controller.getStatusColor(statusText);

                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        MyAppRoutes.detailanggota,
                        arguments: item,
                      ),
                      child: SurveyBox(
                        name: item.fullName,
                        date: DateFormat('yyyy-MMMM-dd', 'id_ID')
                            .format(item.application.trxDate),
                        location: item.sectorCity,
                        image: (item.document?.docPerson.isNotEmpty ?? false)
                            ? item.document!.docPerson[0].img
                            : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
                        status: statusText,
                        statusColor: statusColor,
                        plafond: item.application.plafond,
                        aged: item.aged,
                        trxSurvey: item.application.trxSurvey.toString(),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: GestureDetector(
            onTap: () => Get.offNamed(MyAppRoutes.inputDataScreen),
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
