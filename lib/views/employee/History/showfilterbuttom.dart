import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/History/models_history_location.dart';
import 'package:loan_apllication/widgets/custom_text.dart';
import 'package:loan_apllication/widgets/filtersection.dart';
import 'package:loan_apllication/views/employee/History/location_service.dart';

void showFilterBottomSheet(
    BuildContext context, Function(String) onFilterSelected) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        String selectedDate = '';
        String selectedLocation = '';

        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back),
                        ),
                        CustomText(
                            text: 'Filter',
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),

                  // Body dengan batasan tinggi
                  Expanded(
                    child: FutureBuilder<List<PostModel>>(
                      future: ApiService().fetchPosts(), // Panggil API di sini
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        List<String> locations =
                            snapshot.data!.map((post) => post.name).toList();

                        return ListView(
                          controller: scrollController,
                          children: [
                            // Filter tanggal
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    selectedDate =
                                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  });
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Calender',
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    Icon(Icons.calendar_today,
                                        color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                            Divider(height: 1),

                            // Filter berdasarkan tanggal preset
                            FilterSection(
                              title: 'Tanggal',
                              options: [
                                'Hari ini',
                                'Kemarin',
                                'Minggu ini',
                                'Bulan ini',
                              ],
                              selectedOption: selectedDate,
                              onOptionSelected: (value) {
                                setState(() => selectedDate = value);
                              },
                            ),
                            Divider(height: 1),
                            FilterSection(
                              title: 'Lokasi',
                              options: locations,
                              selectedOption: selectedLocation,
                              onOptionSelected: (value) {
                                setState(() => selectedLocation = value);
                              },
                            ),
                            Divider(height: 1),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = '';
                                selectedLocation = '';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.pureWhite,
                              foregroundColor: AppColors.black,
                            ),
                            child: const Text('Atur Ulang'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedDate.isNotEmpty) {
                                onFilterSelected('DATE:$selectedDate');
                              }
                              if (selectedLocation.isNotEmpty) {
                                onFilterSelected('LOCATION:$selectedLocation');
                              }
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightBlue,
                              foregroundColor: AppColors.pureWhite,
                            ),
                            child: const Text('Pakai'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  );
}
