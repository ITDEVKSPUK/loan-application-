import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onOptionSelected;
  final Color buttonBackgroundColor;
  final Color selectedButtonColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const FilterSection({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.buttonBackgroundColor = AppColors.pureWhite, // Warna default tombol
    this.selectedButtonColor = AppColors.cyanBlue, // Warna tombol saat dipilih
    this.selectedTextColor = Colors.white, // Warna teks saat tombol dipilih
    this.unselectedTextColor =
        Colors.black, // Warna teks saat tombol tidak dipilih
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final bool isSelected = option == selectedOption;
              return ChoiceChip(
                label: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? selectedTextColor : unselectedTextColor,
                  ),
                ),
                selected: isSelected,
                selectedColor: selectedButtonColor, // Warna tombol saat dipilih
                backgroundColor: buttonBackgroundColor, // Warna tombol default
                onSelected: (_) => onOptionSelected(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
