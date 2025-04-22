import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/widgets/searchbar.dart';
import 'package:loan_apllication/widgets/survey_box.dart';
import 'package:loan_apllication/widgets/History/filter_button.dart';

class HistoryEmployee extends StatefulWidget {
  const HistoryEmployee({super.key});

  @override
  State<HistoryEmployee> createState() => _HistoryEmployeeState();
}

class _HistoryEmployeeState extends State<HistoryEmployee> {
  final List<Map<String, String>> historyEmployee = [
    {
      'name': 'Azzam Aqila',
      'date': '20th February 2036',
      'location': 'Kudus, Jawa Utara',
      'status': 'ACCEPTED',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Nadira Salsabila',
      'date': '15th March 2036',
      'location': 'Semarang, Jawa Tengah',
      'status': 'UNREAD',
      'image': 'assets/images/bg.png',
    },
    {
      'name': 'Rizky Fadillah',
      'date': '10th April 2036',
      'location': 'Jakarta, DKI Jakarta',
      'status': 'DECLINED',
      'image': 'assets/images/bg.png',
    },
  ];

  List<Map<String, String>> filteredList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredList = historyEmployee;
    searchController.addListener(() {
      filterSearch(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void filterSearch(String query) {
    setState(() {
      filteredList = historyEmployee
          .where((item) =>
              item['name']!.toLowerCase().contains(query.toLowerCase()) ||
              item['status']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void filterByStatus(String status) {
    setState(() {
      filteredList = historyEmployee
          .where((item) => item['status'] == status)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
            top: 30,
          )),
          CustomSearchBar(
            controller: searchController,
            onChanged: filterSearch,
          ),
          FilterButtons(
            onFilterSelected: filterByStatus,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return SurveyBox(
                  name: item['name']!,
                  date: item['date']!,
                  location: item['location']!,
                  status: item['status']!,
                  image: item['image']!,
                  statusColor: getStatusColor(item['status']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'ACCEPTED':
        return AppColors.greenstatus;
      case 'DECLINED':
        return AppColors.redstatus;
      case 'UNREAD':
        return AppColors.orangestatus;
      default:
        return Colors.grey;
    }
  }
}