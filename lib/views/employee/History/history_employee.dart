import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/SurveyList/home_controller.dart';
import 'package:loan_apllication/widgets/searchbar.dart';
import 'package:loan_apllication/widgets/survey_box.dart';
import 'package:loan_apllication/widgets/History/filter_button.dart';


class HistoryEmployee extends StatefulWidget {
  const HistoryEmployee({super.key});

  @override
  State<HistoryEmployee> createState() => _HistoryEmployeeState();
}

class _HistoryEmployeeState extends State<HistoryEmployee> {
  final HomeController _controller = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.getHistory(); // Fetch history data
    searchController.addListener(() {
      _controller.filterSearch(searchController.text);
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
            onChanged: (query) => _controller.filterSearch(query),
          ),
          FilterButtons(
            onFilterSelected: (status) => _controller.filterByStatus(status),
          ),
          Expanded(
            child: Obx(() {
              if (_controller.surveyList.isEmpty) {
                return const Center(
                  child: Text('No history found'),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _controller.filteredList.length,
                itemBuilder: (context, index) {
                  final item = _controller.filteredList[index];
                  return SurveyBox(
                    name: item.fullName,
                    date: item.application.trxDate,
                    location: item.village,
                    status: "UNREAD",
                    image: 'assets/images/bg.png',
                    statusColor: _controller.getStatusColor("UNREAD"),
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
