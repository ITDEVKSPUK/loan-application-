import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/inputuserdata/formcontroller.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class GoogleMapsScreen extends StatelessWidget {
  const GoogleMapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InputDataController controller = Get.find<InputDataController>();

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
              mapType: MapType.normal,
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
              child: ElevatedButton(
                onPressed: controller.selectedPosition.value != null
                    ? () {
                        Get.back(result: {
                          'latitude':
                              controller.selectedPosition.value!.latitude,
                          'longitude':
                              controller.selectedPosition.value!.longitude,
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selectedPosition.value != null
                      ? AppColors.casualbutton1
                      : Colors.grey,
                  foregroundColor: AppColors.pureWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Select Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Outfit',
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
