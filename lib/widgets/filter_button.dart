import 'package:flutter/material.dart';
import 'package:loan_apllication/views/employee/History/showfilterbuttom.dart';
import 'package:loan_apllication/core/theme/color.dart';

class FilterButtons extends StatelessWidget {
  final Function(String) onFilterSelected;

  const FilterButtons({required this.onFilterSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 310,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildButton('ACCEPTED'),
                SizedBox(width: 5),
                _buildButton('DECLINED'),
                SizedBox(width: 5),
                _buildButton('UNREAD'),
              ],
            ),
          ),
        ),
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
    return SizedBox(
      width: 109,
      child: ElevatedButton(
        onPressed: () => onFilterSelected(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.pureWhite,
          foregroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
