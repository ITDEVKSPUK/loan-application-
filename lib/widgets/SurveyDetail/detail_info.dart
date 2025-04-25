import 'package:flutter/material.dart';

class PersonalInfoWidget extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String nik;
  final String address;
  final String occupation;

  const PersonalInfoWidget({
    required this.name,
    required this.phoneNumber,
    required this.nik,
    required this.address,
    required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 317,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned(
            left: 198,
            top: 4,
            child: Text(
              phoneNumber,
              style: const TextStyle(
                color: Color(0xFFB0B0B0),
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 33,
            child: Text(
              'NIK. $nik',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            left: 190,
            top: 33,
            child: Text(
              occupation,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 60,
            child: SizedBox(
              width: 317,
              child: Text.rich(
                TextSpan(
                  children: _buildAddressTextSpans(address),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildAddressTextSpans(String address) {
    final underlineWords = ['Dki Jakarta', 'Jakarta'];
    return address.splitMapJoin(RegExp(r'\b(?:Dki Jakarta|Jakarta)\b'),
      onMatch: (m) => '',
      onNonMatch: (nonMatch) => '',
    ) == ''
        ? [
            TextSpan(
              text: address,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.w300,
              ),
            )
          ]
        : address.splitMapJoin(
            RegExp(r'\b(?:Dki Jakarta|Jakarta)\b'),
            onMatch: (m) => '\u0000${m[0]}\u0000',
            onNonMatch: (n) => '\u0001$n\u0001',
          )
            .split(RegExp(r'[\u0000\u0001]'))
            .where((e) => e.isNotEmpty)
            .map((e) {
              final isUnderline = underlineWords.contains(e.trim());
              return TextSpan(
                text: e,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w300,
                  decoration:
                      isUnderline ? TextDecoration.underline : TextDecoration.none,
                ),
              );
            }).toList();
  }
}
