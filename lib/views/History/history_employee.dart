import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';
import 'package:loan_application/views/home/home_controller.dart';
import 'package:loan_application/widgets/History/filter_button.dart';
import 'package:loan_application/widgets/searchbar.dart';
import 'package:loan_application/widgets/survey_box.dart';

class HistoryEmployee extends StatefulWidget {
  const HistoryEmployee({super.key});

  @override
  State<HistoryEmployee> createState() => _HistoryEmployeeState();
}

class _HistoryEmployeeState extends State<HistoryEmployee> {
  final HomeController controller = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.getHistory(); // Fetch history data
    searchController.addListener(() {
      controller.filterSearch(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 30),
          CustomSearchBar(
            controller: searchController,
            onChanged: (query) => controller.filterSearch(query),
          ),
          FilterButtons(
            onFilterSelected: (status) => controller.filterByStatus(status),
          ),
          Expanded(
            child: Obx(() {
              if (controller.surveyList.isEmpty) {
                return const Center(
                  child: Text('No history found'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: controller.surveyList.length,
                itemBuilder: (context, index) {
                  final item = controller.surveyList[index];
                  return GestureDetector(
                  onTap: () => Get.toNamed(
                    MyAppRoutes.surveyDetail,
                    arguments: item,
                  ),
                  child: SurveyBox(
                    name: item.fullName,
                    date: DateFormat('yyyy-MM-dd')
                      .format(item.application.trxDate),
                    location: item.sectorCity,
                    status: "UNREAD",
                    image: 'assets/images/bg.png',
                    statusColor: controller.getStatusColor("UNREAD"),
                  ),
                  );
                },
                );
            }),
          ),
        ],
      ),
    );
  }
}
