import 'package:flutter/material.dart';
import 'package:loan_apllication/core/theme/color.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Material(
        elevation: 3, // Tambahkan bayangan ringan
        borderRadius: BorderRadius.circular(15),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: AppColors.blackLight),
            prefixIcon: Icon(Icons.search, color: AppColors.blackLight),
            filled: true,
            fillColor: AppColors.pureWhite,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.blackLight, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.pureWhite, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.pureWhite, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          style: const TextStyle(
            color: AppColors.blackLight,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
