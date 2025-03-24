import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double borderRadius;
  final TextStyle textStyle;
  final double paddingVertical;
  final double paddingHorizontal;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.borderRadius,
    required this.textStyle,
    required this.paddingVertical,
    required this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
