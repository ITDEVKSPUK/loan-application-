import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/History/controller_location.dart';
import 'package:loan_application/widgets/custom_text.dart';

void showLocationBottomSheet(
    BuildContext context,
    Function(String) onLocationSelected,
    LocationController locationController) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
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
                              Text("Provinsi"),
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
                                    value: prov['pro_idn'].toString(),
                                    child: Text(prov['province']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  locationController.selectedProvinceId.value =
                                      value!;
                                  locationController.fetchRegencies(value);
                                },
                              ),
                              if (locationController.regencies.isNotEmpty) ...[
                                Text("Kabupaten"),
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
                                      value: kab['reg_idn'].toString(),
                                      child: Text(kab['region']),
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
                                Text("Kecamatan"),
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
                                      value: kec['sec_idn'].toString(),
                                      child: Text(kec['sector']),
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
                                Text("Desa"),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  hint: Text("Pilih Desa"),
                                  value: locationController
                                          .selectedVillageId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedVillageId.value,
                                  items: locationController.villages
                                      .map<DropdownMenuItem<String>>((vil) {
                                    return DropdownMenuItem<String>(
                                      value: vil['vil_idn'].toString(),
                                      child: Text(vil['village']),
                                    );
                                  }).toList(),
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
                            child: Text('Atur Ulang'),
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
