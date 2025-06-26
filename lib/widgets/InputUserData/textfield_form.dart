import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_application/core/theme/color.dart';

class TextfieldForm extends StatefulWidget {
  final String label;
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool readOnly; // Added readOnly parameter

  const TextfieldForm({
    super.key,
    required this.label,
    required this.controller,
    required this.width,
    required this.height,
    this.hintText = 'KETIK DISINI',
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<TextfieldForm> createState() => _TextfieldFormState();
}

class _TextfieldFormState extends State<TextfieldForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.05),
              border: Border.all(color: AppColors.black.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters ?? [],
              readOnly: widget.readOnly ||
                  widget.onTap != null, // Respect readOnly or onTap
              onTap: widget.onTap,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColors.black.withOpacity(0.2),
                  fontSize: 13,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
