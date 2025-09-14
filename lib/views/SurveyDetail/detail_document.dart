import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:get/get.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/views/SurveyDetail/iqy_document_controller.dart';
import 'package:loan_application/views/SurveyDetail/inqury_survey_controller.dart';
import 'package:loan_application/widgets/SurveyDetail/detail_cardDCM.dart';
import 'package:loan_application/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application/widgets/custom_appbar.dart';

class DetailDocument extends StatefulWidget {
  const DetailDocument({super.key});

  @override
  State<DetailDocument> createState() => _DetailDocumentState();
}

class _DetailDocumentState extends State<DetailDocument> {
  final IqyDocumentController documentController =
      Get.put(IqyDocumentController());
  final SurveyController surveyController = Get.find<SurveyController>();

  @override
  void initState() {
    super.initState();
    final trxSurvey = Get.arguments;
    if (trxSurvey != null && trxSurvey is String && trxSurvey.isNotEmpty) {
      documentController.fetchDocuments(trxSurvey: trxSurvey);
    } else {
      documentController.errorMessage.value =
          'trxSurvey tidak valid atau tidak ditemukan';
      Get.snackbar('Error', documentController.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.pureWhite,
        appBar: CustomAppBar(
          title: 'Detail Dokumen',
        ),
        body: Obx(() {
          if (documentController.isLoading.value) {
            return Stack(
              children: [
                _buildContent(context),
                Container(
                  color: AppColors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.royalBlue),
                    ),
                  ),
                ),
              ],
            );
          }
          if (documentController.errorMessage.value.isNotEmpty) {
            return ErrorWidget(
              errorMessage: documentController.errorMessage.value,
              onRetry: () {
                final trxSurvey = Get.arguments;
                if (trxSurvey != null && trxSurvey is String) {
                  documentController.fetchDocuments(trxSurvey: trxSurvey);
                }
              },
            );
          }
          return _buildContent(context);
        }),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KTP Section
          SectionCard(
            title: 'KTP',
            child: ImageContainer(
              imageUrl: documentController.ktpImage.value,
              placeholderText: 'KTP Tidak Tersedia',
              onTap: () => documentController
                  .showFullScreenImage(documentController.ktpImage.value),
            ),
          ),
          const SizedBox(height: 24),
          // Agunan Section
          SectionCard(
            title: 'Agunan',
            child: Column(
              children: [
                ImageContainer(
                  imageUrl: documentController.img_agun.value,
                  placeholderText: 'Foto Tanah Tidak Tersedia',
                  onTap: () => documentController
                      .showFullScreenImage(documentController.img_agun.value),
                ),
                const SizedBox(height: 12),
                FieldReadonly(
                  label: 'Category Agunan',
                  width: double.infinity,
                  height: 50,
                  value: surveyController.idName.value,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                FieldReadonly(
                  label: 'Deskripsi Agunan',
                  width: double.infinity,
                  height: 50,
                  value: surveyController.descript.value,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                FieldReadonly(
                  label: 'Taksiran Nilai Jaminan',
                  width: double.infinity,
                  height: 50,
                  value:
                      'Rp. ${surveyController.formatRupiah(surveyController.inquiryModel.value?.collateral.value.toString() ?? '0')}',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Document Section
          SectionCard(
            title: 'Dokumen',
            child: Column(
              children: [
                ImageContainer(
                  imageUrl: documentController.img_doc.value,
                  placeholderText: 'Foto Surat Tidak Tersedia',
                  onTap: () => documentController
                      .showFullScreenImage(documentController.img_doc.value),
                ),
                const SizedBox(height: 12),
                FieldReadonly(
                  label: 'Category Document',
                  width: double.infinity,
                  height: 50,
                  value: surveyController.document_type.value,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Note Section
          SectionCard(
            title: 'Note Dokumen',
            child: Center(
              child: Text(
                documentController.noteDocument.value.isEmpty
                    ? 'Tidak ada data'
                    : documentController.noteDocument.value,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Outfit',
                  color:
                      documentController.noteDocument.value.contains('APPROVED')
                          ? AppColors.greenstatus
                          : documentController.noteDocument.value
                                  .contains('DECLINED')
                              ? AppColors.redstatus
                              : AppColors.blackLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
