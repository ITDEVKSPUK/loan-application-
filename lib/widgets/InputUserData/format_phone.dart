import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-allowed characters (keep only +, digits)
    String newText = newValue.text.replaceAll(RegExp(r'[^\+\d]'), '');

    // Check if the number starts with a valid country code (e.g., +1, +62, +376)
    final countryCodeMatch = RegExp(r'^\+(\d{1,4})').firstMatch(newText);
    if (countryCodeMatch == null) {
      return newValue; // Return unformatted if no valid country code
    }

    // Extract country code and rest of the number
    String countryCode = countryCodeMatch.group(0)!; // e.g., +62, +376
    String restOfNumber = newText.substring(countryCode.length); // Digits after country code

    // If the remaining number is too short, return as is
    if (restOfNumber.isEmpty) {
      return TextEditingValue(
        text: countryCode,
        selection: TextSelection.collapsed(offset: countryCode.length),
      );
    }

    // Format based on the length of the remaining digits
    String formatted = countryCode;
    List<String> parts = <String>[];
    if (restOfNumber.length >= 10) {
      // Pattern: 3-3-4 (e.g., +62812-345-6789)
      parts.add(restOfNumber.substring(0, 3));
      parts.add(restOfNumber.substring(3, 6));
      parts.add(restOfNumber.substring(6));
      formatted += ' ${parts.join('-')}';
    } else if (restOfNumber.length >= 7) {
      // Pattern: 3-4 (e.g., +62812-3456)
      parts.add(restOfNumber.substring(0, 3));
      parts.add(restOfNumber.substring(3));
      formatted += ' ${parts.join('-')}';
    } else if (restOfNumber.length >= 4) {
      // Pattern: 3-3 (e.g., +376123-456 for Andorra)
      parts.add(restOfNumber.substring(0, 3));
      parts.add(restOfNumber.substring(3));
      formatted += ' ${parts.join('-')}';
    } else {
      // No dashes for short numbers (e.g., +376123)
      formatted += restOfNumber;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
    
  }
}