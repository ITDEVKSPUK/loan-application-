import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_application/core/theme/color.dart';

class FieldReadonly extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final String hintText;
  final String value;
  final TextInputType? keyboardType;

  const FieldReadonly({
    super.key,
    required this.label,
    required this.value,
    required this.width,
    required this.height,
    this.hintText = 'DATA BELUM ADA',
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = value.trim().isEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.05),
              border: Border.all(color: AppColors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: TextEditingController(text: value),
              keyboardType: keyboardType,
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: isEmpty ? hintText : null,
                hintStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.2),
                  fontSize: 13,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
              ),
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
