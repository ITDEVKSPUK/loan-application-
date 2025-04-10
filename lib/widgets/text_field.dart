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
  final Color borderColor; // Warna border baru
  final double borderWidth; // Ketebalan border baru

  const CustomTextField({super.key, 
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.heigth,
    required this.width,
    required this.color,
    required this.labelStyle,
    required this.filled,
    required this.hintStyle,
    this.borderColor = Colors.blue, // Default warna border
    this.borderWidth = 2.0, // Default ketebalan border
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
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: widget.labelStyle,
          filled: widget.filled,
          fillColor: Colors.white,

          // **Custom Outline Border**
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),

          // **Border saat tidak aktif (default)**
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.borderColor.withOpacity(0.5), // Lebih transparan
              width: widget.borderWidth,
            ),
          ),

          // **Border saat fokus**
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: widget.borderColor, // Warna lebih jelas saat fokus
              width: widget.borderWidth + 1, // Tambah ketebalan
            ),
          ),

          // **Border saat error**
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.red, // Warna merah saat error
              width: widget.borderWidth,
            ),
          ),

          // **Border saat fokus dalam kondisi error**
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.redAccent,
              width: widget.borderWidth + 1,
            ),
          ),

          hintStyle: widget.hintStyle,

          // **Icon show/hide password**
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
