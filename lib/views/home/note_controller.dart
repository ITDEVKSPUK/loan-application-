import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';

class NotePopupController extends GetxController {
  final InqurySurveyController inquiryController = Get.find<InqurySurveyController>();
  final activeTab = 'Document'.obs; // Reactive active tab state

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
    return inquiryController.plafond.value.isEmpty
        ? 'Rp 0,00'
        : inquiryController.plafond.value;
  }
}