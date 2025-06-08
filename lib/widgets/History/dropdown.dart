import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

class DropdownFilter extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final String? value;
  final String labelKey;
  final String idKey;
  final String? hint; // Added hint parameter
  final Function(String?) onChanged;

  const DropdownFilter({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    required this.labelKey,
    required this.idKey,
    required this.onChanged,
    this.hint, // Added hint parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blackLight.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              isExpanded: true,
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.blackGrey),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.pureWhite,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: hint, // Apply hint to InputDecoration
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.blackGrey, // Match dropdown text style
                ),
              ),
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black,
              ),
              dropdownColor: AppColors.pureWhite,
              items: items.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item[idKey].toString(),
                  child: Text(
                    item[labelKey],
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}