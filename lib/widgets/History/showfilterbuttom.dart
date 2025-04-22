import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:loan_apllication/core/theme/color.dart';
import 'package:loan_apllication/views/employee/History/controller_location.dart';
import 'package:loan_apllication/widgets/History/OptionChips.dart';
import 'package:loan_apllication/widgets/History/dropdown.dart';

void showFilterBottomSheet(
    BuildContext context, Function(String) onFilterSelected) async {
  final locationController = Get.put(LocationController());

  // Inisialisasi locale Indonesia untuk formatting tanggal
  await initializeDateFormatting('id_ID', null);

  // Letakkan variabel di luar builder agar tidak di-reset setiap kali rebuild
  String selectedDate = '';
  String selectedDateText = '';
  String selectedLocation = '';
  DateTime _startDate = DateTime.now();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: const Offset(0, -3),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // Drag Indicator
                    Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Header
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.black),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Filter Data',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const Divider(height: 20),

                    // Content
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          // Date Picker
                          ListTile(
                            title: const Text('Calendar'),
                            subtitle: Text(
                              selectedDateText.isNotEmpty
                                  ? selectedDateText
                                  : DateFormat.yMMMMd('id_ID')
                                      .format(_startDate),
                            ),
                            trailing: const Icon(Icons.calendar_today),
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: _startDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        onPrimary: Colors.white,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ).then((picked) {
                                if (picked != null) {
                                  setState(() {
                                    _startDate = picked;
                                    selectedDateText =
                                        DateFormat('d MMMM y', 'id_ID')
                                            .format(picked);
                                    selectedDate =
                                        ''; 
                                  });
                                }
                              });
                            },
                          ),

                          const SizedBox(height: 16),

                          // Opsi Tanggal Cepat
                          OptionChips(
                            title: 'Opsi Tanggal',
                            options: const [
                              'Hari ini',
                              'Kemarin',
                              'Minggu ini',
                              'Bulan ini',
                            ],
                            selectedOption: selectedDate,
                            onOptionSelected: (value) {
                              setState(() {
                                if (selectedDate == value) {
                                  selectedDate = '';
                                  selectedDateText = '';
                                } else {
                                  selectedDate = value;
                                  selectedDateText = '';
                                }
                              });
                            },
                          ),

                           SizedBox(height: 24),

                          // Dropdown lokasi berjenjang
                          Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownFilter(
                                  title: "Provinsi",
                                  items: locationController.provinces,
                                  value: locationController
                                          .selectedProvinceId.value.isEmpty
                                      ? null
                                      : locationController
                                          .selectedProvinceId.value,
                                  labelKey: 'province',
                                  idKey: 'pro_idn',
                                  onChanged: (val) {
                                    locationController
                                        .selectedProvinceId.value = val!;
                                    locationController.fetchRegencies(val);
                                  },
                                ),
                                if (locationController.regencies.isNotEmpty)
                                  DropdownFilter(
                                    title: "Kabupaten",
                                    items: locationController.regencies,
                                    value: locationController
                                            .selectedRegencyId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedRegencyId.value,
                                    labelKey: 'region',
                                    idKey: 'reg_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedRegencyId.value = val!;
                                      locationController.fetchDistricts(val);
                                    },
                                  ),
                                if (locationController.districts.isNotEmpty)
                                  DropdownFilter(
                                    title: "Kecamatan",
                                    items: locationController.districts,
                                    value: locationController
                                            .selectedDistrictId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedDistrictId.value,
                                    labelKey: 'sector',
                                    idKey: 'sec_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedDistrictId.value = val!;
                                      locationController.fetchVillages(val);
                                    },
                                  ),
                                if (locationController.villages.isNotEmpty)
                                  DropdownFilter(
                                    title: "Desa",
                                    items: locationController.villages,
                                    value: locationController
                                            .selectedVillageId.value.isEmpty
                                        ? null
                                        : locationController
                                            .selectedVillageId.value,
                                    labelKey: 'village',
                                    idKey: 'vil_idn',
                                    onChanged: (val) {
                                      locationController
                                          .selectedVillageId.value = val!;
                                    },
                                  ),
                              ],
                            );
                          }),

                         SizedBox(height: 30),

                          // Footer Buttons
                          // Footer Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      selectedDate = '';
                                      selectedDateText = '';
                                      _startDate = DateTime.now();
                                      selectedLocation = '';
                                      locationController.resetAll();
                                    });
                                  },
                                  icon: const Icon(Icons.restart_alt),
                                  label: const Text('Atur Ulang'),
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(color: AppColors.lightBlue),
                                    foregroundColor: AppColors.lightBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width: 16), // Menambah jarak antara tombol
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    List<String> filters = [];

                                    if (selectedDate.isNotEmpty) {
                                      filters.add('DATE:$selectedDate');
                                    } else if (selectedDateText.isNotEmpty) {
                                      filters
                                          .add('DATE_CUSTOM:$selectedDateText');
                                    }

                                    if (locationController
                                        .selectedVillageId.value.isNotEmpty) {
                                      selectedLocation = locationController
                                          .selectedVillageId.value;
                                      filters.add('LOCATION:$selectedLocation');
                                    }

                                    if (filters.isNotEmpty) {
                                      onFilterSelected(filters.join(';'));
                                    }

                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.check),
                                  label: const Text('Terapkan'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.lightBlue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ),
  );
}
