import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:flutter_multi_formatter/formatters/money_input_formatter.dart';
import 'package:loan_application/core/theme/color.dart';

class FieldEditable extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const FieldEditable({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
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
          Material(
            color: Colors.transparent,
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.pureWhite.withOpacity(0.05),
                border: Border.all(color: AppColors.black.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: controller,
                keyboardType: keyboardType ?? TextInputType.text,
                inputFormatters: keyboardType == TextInputType.number
                    ? [
                        FilteringTextInputFormatter.digitsOnly,
                        MoneyInputFormatter(
                          thousandSeparator: ThousandSeparator.Period,
                          mantissaLength: 0,
                        ),
                      ]
                    : [],
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan $label',
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
          ),
        ],
      ),
    );
  }
}