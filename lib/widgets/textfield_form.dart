import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldForm extends StatefulWidget {
  final String label;
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputFormatter? inputFormatter;

  const TextfieldForm({
    
    super.key,
    required this.label,
    required this.controller,
    this.width = 300,
    this.height = 50,
    this.hintText = 'TYPE HERE', this.keyboardType, this.inputFormatter,
  });

  @override
  State<TextfieldForm> createState() => _TextfieldFormState();
}

class _TextfieldFormState extends State<TextfieldForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                inputFormatters: widget.inputFormatter != null ? [widget.inputFormatter!] : [],
                keyboardType: widget.keyboardType,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.2),
                    fontSize: 13,
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
