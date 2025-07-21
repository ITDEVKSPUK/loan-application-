import 'package:flutter/material.dart';
import 'package:loan_application/core/theme/color.dart';

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
                _buildButton(
                  'All',
                  backgroundColor: AppColors.royalBlue,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'APPROVED',
                  backgroundColor: AppColors.greenstatus,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'PROGRESS',
                  backgroundColor: AppColors.orangestatus,
                ),
                const SizedBox(width: 8),
                _buildButton(
                  'DECLINED',
                  backgroundColor: AppColors.redstatus,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ],
    );
  }
 Widget _buildButton(String text,
      {Color? backgroundColor, Color? foregroundColor}) {
    return ElevatedButton(
      onPressed: () => onFilterSelected(text),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? AppColors.pureWhite, // Fallback ke pureWhite
        foregroundColor:
            foregroundColor ?? AppColors.pureWhite, // Fallback ke black
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
