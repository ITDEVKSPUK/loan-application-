import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';

class MapTypeOptionWidget extends StatelessWidget {
  final MapType type;
  final String label;
  final ImageProvider image;
  final InputDataController controller;

  const MapTypeOptionWidget({
    super.key,
    required this.type,
    required this.label,
    required this.image,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.mapType.value == type;
    return GestureDetector(
      onTap: () {
        controller.mapType.value = type;
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}