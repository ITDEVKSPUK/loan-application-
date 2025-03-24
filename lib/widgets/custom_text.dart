import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.fontFamily,
    this.fontStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.copyWith(
        fontSize: fontSize ?? style?.fontSize,
        fontWeight: fontWeight ?? style?.fontWeight,
        color: color ?? style?.color,
        fontFamily: fontFamily ?? style?.fontFamily,
        fontStyle: fontStyle ?? style?.fontStyle,
      ) ?? 
      TextStyle(
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? Colors.black,
        fontFamily: fontFamily ?? 'OutfitRegular',
        fontStyle: fontStyle ?? FontStyle.normal,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}