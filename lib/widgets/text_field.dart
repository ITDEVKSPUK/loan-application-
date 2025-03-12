import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final double heigth;
  final double width;
  final Color color;
  final TextStyle labelStyle;
  final bool filled;
  final TextStyle hintStyle;

  CustomTextField({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.heigth,
    required this.width,
    required this.color,
    required this.labelStyle, required this.filled, required this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: color),
          filled: filled, // Aktifkan warna latar belakang
          fillColor: Colors.white, // Warna latar belakang putih
          border: OutlineInputBorder(),
          hintStyle: TextStyle(
            color: color, // Warna teks abu-abu
          )
        ),
      ),
    );
  }
}
