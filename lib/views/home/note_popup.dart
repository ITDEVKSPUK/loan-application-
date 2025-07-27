import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/home/note_controller.dart';

class NotePopup extends StatelessWidget {
  const NotePopup({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final NotePopupController controller = Get.put(NotePopupController());

    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with icon
            const Row(
              children: [
                Text(
                  'Catatan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tabs
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.switchTab('Document'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.activeTab.value == 'Document'
                                ? AppColors.casualbutton1
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Document',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.activeTab.value == 'Document'
                                    ? AppColors.pureWhite
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.switchTab('Agunan'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: controller.activeTab.value == 'Agunan'
                                ? AppColors.casualbutton1
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Agunan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.activeTab.value == 'Agunan'
                                    ? AppColors.pureWhite
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            const SizedBox(height: 20),

            // Content Box
            Obx(() {
              if (controller.inquiryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Plafond: ${controller.getPlafondToShow()}\nNote: ${controller.getNoteToShow()}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              );
            }),

            const SizedBox(height: 20),

            // Close button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: AppColors.black),
                    SizedBox(width: 6),
                    Text(
                      'Close',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}