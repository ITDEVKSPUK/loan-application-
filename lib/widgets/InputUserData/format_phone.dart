import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-allowed characters (keep only +, digits)
    String newText = newValue.text.replaceAll(RegExp(r'[^\+\d]'), '');

    // Check if the number starts with a valid country code (e.g., +1, +62, +376)
    final countryCodeMatch = RegExp(r'^\+(\d{1,2})').firstMatch(newText);
    if (countryCodeMatch == null) {
      return newValue; // Return unformatted if no valid country code
    }

    // Extract country code and rest of the number
    String countryCode = countryCodeMatch.group(0)!; // e.g., +62, +376
    String restOfNumber =
        newText.substring(countryCode.length); // Digits after country code

    // If the remaining number is empty, return country code only
    if (restOfNumber.isEmpty) {
      return TextEditingValue(
        text: countryCode,
        selection: TextSelection.collapsed(offset: countryCode.length),
      );
    }

    // Format based on desired pattern: +62 856-2430-<rest without limit>
    String formatted = countryCode;
    List<String> parts = <String>[];

    // Apply 3-3-4 pattern for 10+ digits, with no limit on last part
    if (restOfNumber.length >= 10) {
      // Take first 3 digits
      parts.add(restOfNumber.substring(0, 3));
      // Take next 4 digits
      parts.add(restOfNumber.substring(3, 7));
      // Take all remaining digits without limit
      parts.add(restOfNumber.substring(7));
      formatted += ' ${parts.join('-')}';
    } else if (restOfNumber.length >= 7) {
      // Pattern: 3-4 (e.g., +62 856-2430)
      parts.add(restOfNumber.substring(0, 3));
      parts.add(restOfNumber.substring(3));
      formatted += ' ${parts.join('-')}';
    } else if (restOfNumber.length >= 4) {
      // Pattern: 3-3 (e.g., +376 123-456)
      parts.add(restOfNumber.substring(0, 3));
      parts.add(restOfNumber.substring(3));
      formatted += ' ${parts.join('-')}';
    } else {
      // No dashes for short numbers (e.g., +376 123)
      formatted += ' $restOfNumber';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
