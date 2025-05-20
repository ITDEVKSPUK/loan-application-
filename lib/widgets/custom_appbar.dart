import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.casualbutton1, width: 7),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol Back
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: onBack ?? () => Get.back(),
          ),

          // Judul di tengah
          Expanded(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // Actions (misal tombol edit)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions ?? [const SizedBox(width: 48)], // agar tetap sejajar meski kosong
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(73);
}
