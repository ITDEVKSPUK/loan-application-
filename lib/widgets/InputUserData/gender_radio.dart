import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderRadioButtons extends StatelessWidget {
  final bool isReadOnly;
  final int? genderFromApi;
  final RxString? gender;

  const GenderRadioButtons({
    super.key,
    required this.isReadOnly,
    this.genderFromApi,
    this.gender,
  });

  String _mapGender(int? value) {
    if (value == 0) return '0';
    return '1';
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
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: const EdgeInsets.only(right: 0),
                    title: const Text('Laki-laki'),
                    value: '1',
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
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: const EdgeInsets.only(left: 0),
                    title: const Text('Perempuan'),
                    value: '0',
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
                ),
              ],
            ),
          ],
        ));
  }
}
