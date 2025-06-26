import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/widgets/InputUserData/type_maps.dart';
import 'package:loan_application/widgets/custom_appbar.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InputDataController controller = Get.find<InputDataController>();
    final double screenHeight = MediaQuery.of(context).size.height;
    const double baseTopOffset = 16.0;
    const double buttonSpacing = 8.0;
    final double mapTypeTopOffset = baseTopOffset + 60.0 + buttonSpacing;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Location',
        onBack: () => Get.back(),
      ),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.initialPosition.value,
                zoom: 15,
              ),
              onMapCreated: controller.onMapCreated,
              onTap: controller.onMapTap,
              mapType: controller.mapType.value,
              markers: controller.selectedPosition.value != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected-location'),
                        position: controller.selectedPosition.value!,
                      ),
                    }
                  : {}, // Only show marker after a tap
              myLocationEnabled: controller.locationServiceEnabled.value,
              myLocationButtonEnabled: controller.locationServiceEnabled.value,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer()),
              },
            ),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: GestureDetector(
                onTap: controller.selectedPosition.value != null
                    ? () {
                        Get.back(result: {
                          'latitude':
                              controller.selectedPosition.value!.latitude,
                          'longitude':
                              controller.selectedPosition.value!.longitude,
                        });
                      }
                    : null,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: controller.selectedPosition.value != null
                        ? AppColors.casualbutton1
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Outfit',
                        color: controller.selectedPosition.value != null
                            ? AppColors.pureWhite
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: mapTypeTopOffset,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  MapTypeDialogWidget.show(context, controller);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  child: Icon(
                    Icons.layers,
                    color: AppColors.blackGrey.withOpacity(0.7),
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
