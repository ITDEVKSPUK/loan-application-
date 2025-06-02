import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/History/controller_location.dart';
import 'package:loan_application/widgets/History/dropdown.dart';
import 'package:loan_application/widgets/custom_text.dart';

void showLocationBottomSheet(
    BuildContext context, Function(String) onLocationSelected) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
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
                          text: 'Pilih Lokasi',
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(() {
                      if (locationController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (locationController.errorMessage.value.isNotEmpty) {
                        return Center(
                          child: Text(
                            locationController.errorMessage.value,
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return ListView(
                        controller: scrollController,
                        padding: EdgeInsets.all(16),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Dropdown untuk Provinsi
                              DropdownFilter(
                                title: 'Provinsi',
                                items: locationController.provinces,
                                value: locationController
                                        .selectedProvinceId.value.isEmpty
                                    ? null
                                    : locationController
                                        .selectedProvinceId.value,
                                hint: 'Pilih Provinsi',
                                labelKey: 'province',
                                idKey: 'pro_idn',
                                onChanged: (value) {
                                  locationController.selectedProvinceId.value =
                                      value!;
                                  final selectedItem =
                                      locationController.provinces.firstWhere(
                                    (element) =>
                                        element['pro_idn'].toString() ==
                                        value.toString(),
                                    orElse: () => {},
                                  );

                                  locationController.selectedProvinceName.value =
                                      selectedItem['province'] ?? '';
                                  locationController.selectedRegencyName.value =
                                      '';
                                  locationController.selectedDistrictName
                                      .value = '';
                                  locationController.selectedVillageName.value =
                                      '';
                                  print(
                                      'Nama provinsi terpilih: ${locationController.selectedProvinceName.value}');
                                  locationController.fetchRegencies(value);
                                },
                              ),

                              // Dropdown untuk Kabupaten
                              if (locationController.regencies.isNotEmpty) ...[
                                DropdownFilter(
                                  title: 'Kabupaten',
                                  items: locationController.regencies,
                                  value: locationController
                                          .selectedRegencyId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedRegencyId.value,
                                  hint: 'Pilih Kabupaten',
                                  labelKey: 'region',
                                  idKey: 'reg_idn',
                                  onChanged: (value) {
                                    locationController.selectedRegencyId.value =
                                        value!;
                                    final selectedItem = locationController
                                        .regencies
                                        .firstWhere(
                                      (element) =>
                                          element['reg_idn'].toString() ==
                                          value.toString(),
                                      orElse: () => {},
                                    );

                                    locationController.selectedRegencyName
                                        .value = selectedItem['region'] ?? '';
                                    locationController.selectedDistrictName
                                        .value = '';
                                    locationController.selectedVillageName
                                        .value = '';
                                    print(
                                        'Nama kabupaten terpilih: ${locationController.selectedRegencyName.value}');
                                    locationController.fetchDistricts(value);
                                  },
                                ),
                              ],

                              // Dropdown untuk Kecamatan
                              if (locationController.districts.isNotEmpty) ...[
                                DropdownFilter(
                                  title: 'Kecamatan',
                                  items: locationController.districts,
                                  value: locationController
                                          .selectedDistrictId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedDistrictId.value,
                                  hint: 'Pilih Kecamatan',
                                  labelKey: 'sector',
                                  idKey: 'sec_idn',
                                  onChanged: (value) {
                                    locationController.selectedDistrictId.value =
                                        value!;
                                    final selectedItem = locationController
                                        .districts
                                        .firstWhere(
                                      (element) =>
                                          element['sec_idn'].toString() ==
                                          value.toString(),
                                      orElse: () => {},
                                    );

                                    locationController.selectedDistrictName
                                        .value = selectedItem['sector'] ?? '';
                                    locationController.selectedVillageName
                                        .value = '';
                                    print(
                                        'Nama kecamatan terpilih: ${locationController.selectedDistrictName.value}');
                                    locationController.fetchVillages(value);
                                  },
                                ),
                              ],

                              // Dropdown untuk Desa
                              if (locationController.villages.isNotEmpty) ...[
                                DropdownFilter(
                                  title: 'Desa',
                                  items: locationController.villages,
                                  value: locationController
                                          .selectedVillageId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedVillageId.value,
                                  hint: 'Pilih Desa',
                                  labelKey: 'village',
                                  idKey: 'vil_idn',
                                  onChanged: (value) {
                                    locationController.selectedVillageId.value =
                                        value!;
                                    final selectedItem = locationController
                                        .villages
                                        .firstWhere(
                                      (element) =>
                                          element['vil_idn'].toString() ==
                                          value.toString(),
                                      orElse: () => {},
                                    );

                                    locationController.selectedVillageName
                                        .value = selectedItem['village'] ?? '';
                                    print(
                                        'Nama desa terpilih: ${locationController.selectedVillageName.value}');
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              locationController.resetAll();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, color: Colors.black),
                                SizedBox(width: 8),
                                Text('Atur Ulang'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              final selected = [
                                locationController.selectedProvinceName.value,
                                locationController.selectedRegencyName.value,
                                locationController.selectedDistrictName.value,
                                locationController.selectedVillageName.value,
                              ].where((e) => e.isNotEmpty).join('-');

                              onLocationSelected(selected);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightBlue,
                              foregroundColor: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check, color: Colors.white),
                                SizedBox(width: 8),
                                Text('Pakai'),
                              ],
                            ),
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