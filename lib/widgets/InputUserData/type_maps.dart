import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/widgets/InputUserData/google_maps.dart';

class MapTypeDialogWidget extends StatelessWidget {
  final InputDataController controller;

  const MapTypeDialogWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Map type',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MapTypeOptionWidget(
                  type: MapType.normal,
                  label: 'Default',
                  image: AssetImage("assets/images/default.png"),
                  controller: controller,
                ),
                MapTypeOptionWidget(
                  type: MapType.hybrid,
                  label: 'Satellite',
                  image: AssetImage("assets/images/satelit.png"),
                  controller: controller,
                ),
                MapTypeOptionWidget(
                  type: MapType.terrain,
                  label: 'Terrain',
                  image: AssetImage("assets/images/terrain.png"),
                  controller: controller,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, InputDataController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          MapTypeDialogWidget(controller: controller),
    );
  }
}
