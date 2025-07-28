import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:intl/intl.dart';

class NotePopupController extends GetxController with GetSingleTickerProviderStateMixin {
  final InqurySurveyController inquiryController = Get.find<InqurySurveyController>();
  final activeTab = 'Document'.obs; // Reactive active tab state
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;
  final String tag = UniqueKey().toString(); // Unique tag for controller instance

  @override
  void onInit() {
    super.onInit();
    // Initialize the AnimationController
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Animation duration
    );

    // Define scale animation (from 0.8 to 1.0)
    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Define opacity animation (from 0.0 to 1.0)
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  // Method to reset and start the animation
  void resetAndStartAnimation() {
    animationController.reset(); // Reset the animation to initial state
    animationController.forward(); // Start the animation
  }

  // Method to reverse the animation
  Future<void> reverseAnimation() async {
    await animationController.reverse();
  }

  @override
  void onClose() {
    // Dispose of the AnimationController
    animationController.dispose();
    super.onClose();
  }

  // Method to switch tabs
  void switchTab(String tab) {
    activeTab.value = tab;
  }

  // Method to get the note based on the active tab
  String getNoteToShow() {
    final model = inquiryController.inquiryModel.value;
    if (model == null) {
      return 'Data tidak tersedia';
    }

    String noteToShow = 'Tidak ada catatan';
    if (activeTab.value == 'Document') {
      noteToShow = model.collaboration
              .firstWhere(
                (col) => col.content == 'DOC',
                orElse: () => Collaboration(
                    approvalNo: '',
                    category: '',
                    content: '',
                    judgment: '',
                    date: '',
                    note: 'Tidak ada catatan dokumen'),
              )
              .note ??
          'Tidak ada catatan dokumen';
    } else {
      noteToShow = model.collaboration
              .firstWhere(
                (col) => col.content == 'PLAF',
                orElse: () => Collaboration(
                    approvalNo: '',
                    category: '',
                    content: '',
                    judgment: '',
                    date: '',
                    note: 'Tidak ada catatan agunan'),
              )
              .note ??
          'Tidak ada catatan agunan';
    }
    return noteToShow;
  }

  // Method to get the formatted plafond
  String getPlafondToShow() {
    if (inquiryController.plafond.value.isEmpty) {
      return 'Rp 0,00';
    }

    // Parse the plafond value to a number (assuming it's a valid number string)
    try {
      final plafondValue = double.parse(inquiryController.plafond.value.replaceAll(RegExp(r'[^0-9.]'), ''));

      // Format the number using intl package with Indonesian locale
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp ',
        decimalDigits: 2,
      );
      return formatter.format(plafondValue);
    } catch (e) {
      return 'Rp 0,00'; // Fallback in case of parsing error
    }
  }
}