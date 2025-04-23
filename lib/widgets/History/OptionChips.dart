import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

class OptionChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onOptionSelected;

  const OptionChips({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = selectedOption == option;
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onOptionSelected(option),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.pureWhite : AppColors.black,
              ),
              selectedColor: AppColors.navyBlue,  // Ganti dengan warna biru navy
              backgroundColor: AppColors.pureWhite,  // Warna latar belakang putih
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            );
          }).toList(),
        ),
      ],
    );
  }
}
