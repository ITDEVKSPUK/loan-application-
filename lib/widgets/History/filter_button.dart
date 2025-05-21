import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/widgets/History/showfilterbuttom.dart';

class FilterButtons extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({required this.onFilterSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Bagian tombol scrollable horizontal
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8), // Padding awal
                _buildButton('ALL'),
                const SizedBox(width: 8),
                _buildButton('Disetujui'),
                const SizedBox(width: 8),
                _buildButton('Proces'),
                const SizedBox(width: 8),
                _buildButton('Ditolak'),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),

        // Tombol filter icon
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => showFilterBottomSheet(context, onFilterSelected),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.pureWhite,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Icon(Icons.filter_list_alt,
              size: 25, color: AppColors.blackLight),
        ),
      ],
    );
  }

  Widget _buildButton(String text) {
    return ElevatedButton(
      onPressed: () => onFilterSelected(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pureWhite,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
