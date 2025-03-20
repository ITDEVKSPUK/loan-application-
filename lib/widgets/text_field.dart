import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
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
  final Color borderColor;
  final double borderWidth;
  final Function(String)? onChanged; // Tambahkan ini

  CustomTextField({
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.heigth = 50.0,
    this.width = double.infinity,
    this.color = Colors.white,
    this.labelStyle = const TextStyle(color: Colors.black),
    this.filled = true,
    this.hintStyle = const TextStyle(color: Colors.grey),
    this.borderColor = Colors.blue,
    this.borderWidth = 2.0,
    this.onChanged, // Tambahkan ini
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heigth,
      width: widget.width,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ? _isObscured : false,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged, // Tambahkan ini
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: widget.labelStyle,
          filled: widget.filled,
          fillColor: widget.color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          hintStyle: widget.hintStyle,
        ),
      ),
    );
  }
}
