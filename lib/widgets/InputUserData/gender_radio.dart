import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderRadioButtons extends StatelessWidget {
  final bool isReadOnly;
  final int? genderFromApi; 
  final RxString? gender; 

  const GenderRadioButtons({
    super.key,
    this.isReadOnly = false,
    this.genderFromApi,
    this.gender,
  });

  String _mapGender(int? value) {
    if (value == 0) return 'Perempuan';
    return 'Laki-laki';
  }

  @override
  Widget build(BuildContext context) {
    final RxString genderValue = gender ?? RxString(_mapGender(genderFromApi));

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Jenis Kelamin',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Outfit',
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              children: ['Laki-laki', 'Perempuan'].map((String gender) {
                final bool isSelected = genderValue.value == gender;
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(gender),
                    value: gender,
                    groupValue: genderValue.value,
                    onChanged: isReadOnly
                        ? null
                        : (String? value) {
                            if (value != null) {
                              genderValue.value = value;
                            }
                          },
                    activeColor: Colors.blue,
                  ),
                );
              }).toList(),
            ),
          ],
        ));
  }
}
