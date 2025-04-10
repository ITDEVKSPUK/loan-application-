import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/History/controller_location.dart';
import 'package:loan_apllication/widgets/custom_text.dart';
import 'package:loan_apllication/widgets/filtersection.dart';

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

        final locationController = Get.put(LocationController());

        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
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
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      children: [
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
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Kalender",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Icon(Icons.calendar_today, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 24),
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
                        Divider(height: 24),

                        // =============================
                        // Dropdown Lokasi Berjenjang
                        // =============================
                        Obx(() {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Pilih Provinsi"),
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("Pilih Provinsi"),
                                value: locationController
                                        .selectedProvinceId.value.isEmpty
                                    ? null
                                    : locationController
                                        .selectedProvinceId.value,
                                items: locationController.provinces
                                    .map<DropdownMenuItem<String>>((prov) {
                                  return DropdownMenuItem<String>(
                                    value: prov['id'],
                                    child: Text(prov['name']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  print('Selected province: $value');
                                  locationController.selectedProvinceId.value =
                                      value!;
                                  locationController.fetchRegencies(value);
                                },
                              ),
                              if (locationController.regencies.isNotEmpty) ...[
                                Text("Pilih Kabupaten"),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Pilih Kabupaten"),
                                  value: locationController
                                          .selectedRegencyId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedRegencyId.value,
                                  items: locationController.regencies
                                      .map<DropdownMenuItem<String>>((kab) {
                                    return DropdownMenuItem<String>(
                                      value: kab['id'],
                                      child: Text(kab['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    locationController.selectedRegencyId.value =
                                        value!;
                                    locationController.fetchDistricts(value);
                                  },
                                ),
                              ],
                              if (locationController.districts.isNotEmpty) ...[
                                Text("Pilih Kecamatan"),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Pilih Kecamatan"),
                                  value: locationController
                                          .selectedDistrictId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedDistrictId.value,
                                  items: locationController.districts
                                      .map<DropdownMenuItem<String>>((kec) {
                                    return DropdownMenuItem<String>(
                                      value: kec['id'],
                                      child: Text(kec['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    locationController
                                        .selectedDistrictId.value = value!;
                                    locationController.fetchVillages(value);
                                  },
                                ),
                              ],
                              if (locationController.villages.isNotEmpty) ...[
                                Text("Pilih Desa"),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Pilih Desa"),
                                  items: locationController.villages
                                      .map<DropdownMenuItem<String>>((desa) {
                                    return DropdownMenuItem<String>(
                                      value: desa['id'],
                                      child: Text(desa['name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedLocation = value!;
                                    });
                                  },
                                ),
                              ],
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
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
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Text('Atur Ulang'),
                          ),
                        ),
                        SizedBox(width: 16),
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
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Pakai'),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    ),
  );
}
