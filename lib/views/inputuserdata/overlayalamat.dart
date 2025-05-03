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
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.all(16),
                      children: [
                        Obx(() {
                          return Column(
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
                                labelKey:
                                    'province', // Nama key label di dalam item
                                idKey: 'pro_idn', // Nama key id di dalam item
                                onChanged: (value) {
                                  locationController.selectedProvinceId.value =
                                      value!;
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
                                  labelKey:
                                      'region', // Nama key label di dalam item
                                  idKey: 'reg_idn', // Nama key id di dalam item
                                  onChanged: (value) {
                                    locationController.selectedRegencyId.value =
                                        value!;
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
                                  labelKey:
                                      'sector', // Nama key label di dalam item
                                  idKey: 'sec_idn', // Nama key id di dalam item
                                  onChanged: (value) {
                                    locationController
                                        .selectedDistrictId.value = value!;
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
                                  labelKey:
                                      'village', // Nama key label di dalam item
                                  idKey: 'vil_idn', // Nama key id di dalam item
                                  onChanged: (value) {
                                    locationController.selectedVillageId.value =
                                        value!;
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
                              locationController.selectedProvinceId.value = '';
                              locationController.selectedRegencyId.value = '';
                              locationController.selectedDistrictId.value = '';
                              locationController.selectedVillageId.value = '';
                              locationController.regencies.clear();
                              locationController.districts.clear();
                              locationController.villages.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh,
                                    color: Colors.black), // Icon refresh
                                SizedBox(
                                    width: 8), // Spacing between icon and text
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
                                locationController.selectedProvinceId.value,
                                locationController.selectedRegencyId.value,
                                locationController.selectedDistrictId.value,
                                locationController.selectedVillageId.value,
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
                                Icon(Icons.check,
                                    color: Colors.white), // Icon check
                                SizedBox(
                                    width: 8), // Spacing between icon and text
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
