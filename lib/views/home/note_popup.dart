import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';

class NotePopup extends StatefulWidget {
  const NotePopup({super.key});

  @override
  State<NotePopup> createState() => _NotePopupState();
}

class _NotePopupState extends State<NotePopup> {
  final InqurySurveyController controller = Get.put(InqurySurveyController());
  Color documentColor = Colors.grey[300]!;
  Color agunanColor = Colors.grey[300]!;
  String activeTab = 'Document';

  @override
  void initState() {
    super.initState();
    // Ensure data is fetched when popup opens
    // This should be triggered from SurveyBox with dynamic trxSurvey
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Note :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = 'Document';
                        documentColor = Colors.blue;
                        agunanColor = Colors.grey[300]!;
                      });
                    },
                    child: Container(
                      height: 30,
                      color: documentColor,
                      child: const Center(child: Text('Document')),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeTab = 'Agunan';
                        agunanColor = Colors.blue;
                        documentColor = Colors.grey[300]!;
                      });
                    },
                    child: Container(
                      height: 30,
                      color: agunanColor,
                      child: const Center(child: Text('Agunan')),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.maxFinite,
              color: Colors.grey[300],
              child: Obx(() {
                print('Inquiry Model: ${controller.inquiryModel.value}');
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.inquiryModel.value == null) {
                  return const Center(child: Text('No data available'));
                }
                final model = controller.inquiryModel.value!;
                String noteToShow = 'No note available';
                String plafondToShow = controller.plafond.value.isEmpty
                    ? 'Rp 0,00'
                    : controller.plafond.value;
                if (activeTab == 'Document') {
                  noteToShow = model.collaboration
                          .firstWhere(
                            (col) => col.content == 'DOC',
                            orElse: () => Collaboration(
                                approvalNo: '',
                                category: '',
                                content: '',
                                judgment: '',
                                date: '',
                                note: 'No document note'),
                          )
                          .note ??
                      'No document note';
                } else if (activeTab == 'Agunan') {
                  noteToShow = model.collaboration
                          .firstWhere(
                            (col) => col.content == 'PLAF',
                            orElse: () => Collaboration(
                                approvalNo: '',
                                category: '',
                                content: '',
                                judgment: '',
                                date: '',
                                note: 'No agunan note'),
                          )
                          .note ??
                      'No agunan note';
                }
                return Center(
                  child: Text(
                    'Plafond: $plafondToShow\nNote: $noteToShow',
                    textAlign: TextAlign.center,
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
