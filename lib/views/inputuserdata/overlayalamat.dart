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

                                  final selectedItem =
                                      locationController.provinces.firstWhere(
                                    (element) =>
                                        element['pro_idn'].toString() ==
                                        value.toString(),
                                    orElse: () => null,
                                  );

                                  if (selectedItem != null) {
                                    locationController.selectedProvinceName
                                        .value = selectedItem['province'] ?? '';
                                    print(
                                        'Nama region terpilih: ${locationController.selectedProvinceName.value}');
                                  } else {
                                    locationController
                                        .selectedProvinceName.value = '';
                                    print(
                                        'prov dengan sec_idn $value tidak ditemukan!');
                                  }

                                  // Simpan nama sektor ke selectedDistrictName
                                  locationController.selectedRegencyName.value =
                                      selectedItem['province'] ?? '';

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
                                    final selectedItem =
                                        locationController.regencies.firstWhere(
                                      (element) =>
                                          element['reg_idn'].toString() ==
                                          value.toString(),
                                      orElse: () => null,
                                    );

                                    if (selectedItem != null) {
                                      locationController.selectedRegencyName
                                          .value = selectedItem['region'] ?? '';
                                      print(
                                          'Nama region terpilih: ${locationController.selectedRegencyName.value}');
                                    } else {
                                      locationController
                                          .selectedRegencyName.value = '';
                                      print(
                                          'region dengan sec_idn $value tidak ditemukan!');
                                    }

                                    // Simpan nama sektor ke selectedDistrictName
                                    locationController.selectedRegencyName
                                        .value = selectedItem['region'] ?? '';

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
                                    idKey:
                                        'sec_idn', // Nama key id di dalam item
                                    onChanged: (value) {
                                      // Simpan ID yang dipilih
                                      locationController
                                          .selectedDistrictId.value = value!;
                                      print(
                                          'Isi districts: ${locationController.districts}');

                                      // Temukan nama sektor (label) berdasarkan ID
                                      final selectedItem = locationController
                                          .districts
                                          .firstWhere(
                                        (element) =>
                                            element['sec_idn'].toString() ==
                                            value.toString(),
                                        orElse: () => null,
                                      );

                                      if (selectedItem != null) {
                                        locationController
                                                .selectedDistrictName.value =
                                            selectedItem['sector'] ?? '';
                                        print(
                                            'Nama sektor terpilih: ${locationController.selectedDistrictName.value}');
                                      } else {
                                        locationController
                                            .selectedDistrictName.value = '';
                                        print(
                                            'District dengan sec_idn $value tidak ditemukan!');
                                      }

                                      // Simpan nama sektor ke selectedDistrictName
                                      locationController.selectedDistrictName
                                          .value = selectedItem['sector'] ?? '';

                                      print(locationController
                                          .selectedDistrictName.value);
                                      // Lanjutkan ambil data desa
                                      locationController.fetchVillages(value);
                                    }),
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
                                    final selectedItem =
                                        locationController.villages.firstWhere(
                                      (element) =>
                                          element['vil_idn'].toString() ==
                                          value.toString(),
                                      orElse: () => null,
                                    );

                                    if (selectedItem != null) {
                                      locationController
                                              .selectedVillageName.value =
                                          selectedItem['village'] ?? '';
                                      print(
                                          'Nama region terpilih: ${locationController.selectedVillageName.value}');
                                    } else {
                                      locationController
                                          .selectedVillageName.value = '';
                                      print(
                                          'desa dengan sec_idn $value tidak ditemukan!');
                                    }

                                    // Simpan nama sektor ke selectedDistrictName
                                    locationController.selectedVillageName
                                        .value = selectedItem['village'] ?? '';
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
                              locationController.selectedProvinceName.value =
                                  '';
                              locationController.selectedRegencyName.value = '';
                              locationController.selectedDistrictName.value =
                                  '';
                              locationController.selectedVillageName.value = '';
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
