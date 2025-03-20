import 'package:flutter/material.dart';
import 'package:loan_apllication/widgets/filtersection.dart';

void showFilterBottomSheet(BuildContext context, Function(String) onFilterSelected) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        String selectedStatus = '';
        String selectedLocation = '';

        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              // App Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text(
                      'Filter',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 24),
                  ],
                ),
              ),
              // Filter Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FilterSection(
                        title: 'Status',
                        options: ['ACCEPTED', 'DECLINED', 'UNREAD'],
                        selectedOption: selectedStatus,
                        onOptionSelected: (value) {
                          setState(() => selectedStatus = value);
                        },
                      ),
                      const Divider(height: 1),
                      FilterSection(
                        title: 'Lokasi',
                        options: [
                          'Jakarta, DKI Jakarta',
                          'Semarang, Jawa Tengah',
                          'Kudus, Jawa Utara',
                          'Surabaya, Jawa Timur',
                          'Bandung, Jawa Barat',
                          'Yogyakarta, DI Yogyakarta',
                        ],
                        selectedOption: selectedLocation,
                        onOptionSelected: (value) {
                          setState(() => selectedLocation = value);
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  ),
                ),
              ),
              // Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedStatus = '';
                            selectedLocation = '';
                          });
                        },
                        child: const Text('Atur Ulang'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (selectedStatus.isNotEmpty) {
                            onFilterSelected(selectedStatus);
                          } else if (selectedLocation.isNotEmpty) {
                            onFilterSelected('LOCATION:$selectedLocation');
                          }
                          Navigator.pop(context);
                        },
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
    ),
  );
}
