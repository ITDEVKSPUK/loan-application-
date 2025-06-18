import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-allowed characters (keep only +, digits)
    String newText = newValue.text.replaceAll(RegExp(r'[^\+\d]'), '');

    // Format the phone number (e.g., +6281234567890 -> +62 812 3456 7890)
    if (newText.startsWith('+')) {
      String formatted = '';
      if (newText.length > 3) {
        formatted += newText.substring(0, 3) + ' '; // Add space after +62
        if (newText.length > 6) {
          formatted += newText.substring(3, 6) + ' '; // Add space after first 3 digits
          if (newText.length > 9) {
            formatted += newText.substring(6, 9) + ' '; // Add space after next 3 digits
            formatted += newText.substring(9); // Add remaining digits
          } else {
            formatted += newText.substring(6); // Add remaining digits
          }
        } else {
          formatted += newText.substring(3); // Add remaining digits
        }
      } else {
        formatted = newText; // Handle shorter inputs
      }
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    return newValue; // Return unformatted if no + at start
  }
}