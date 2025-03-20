import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppBar({super.key, required this.title, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: preferredSize.height,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 19,
            child: GestureDetector(
              onTap: onBack ?? () => Get.back(),
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Positioned(
            top: 19,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: Get.width,
              height: 7,
              decoration: BoxDecoration(color: Color(0xFF83BBF5)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(73);
}
