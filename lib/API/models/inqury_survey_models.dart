import 'package:get/get.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';

import 'package:get/get.dart';
import 'package:loan_application/API/models/inqury_survey_models.dart';
import 'package:loan_application/API/service/post_inqury_survey.dart';

class InqurySurveyController extends GetxController {
  var plafond = ''.obs;
  var purpose = ''.obs;
  var adddescript = ''.obs;
  var value = ''.obs;
  var income = ''.obs;
  var asset = ''.obs;
  var expenses = ''.obs;
  var installment = ''.obs;
  var inquiryModel = Rxn<InquirySurveyModel>();
  var collateralProofs = <CollateralProofModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void getSurveyList({required String trxSurvey}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquryService = PostInqury();
    print('Requesting data for trxSurvey: $trxSurvey, officeId: 000');

    try {
      final inquryResponse = await inquryService.fetchInqury(
        officeId: '000',
        trxSurvey: trxSurvey,
      );
      print('Response: $inquryResponse');
      inquiryModel.value = inquryResponse;
      plafond.value = inquryResponse.application.plafond;
      purpose.value = inquryResponse.application.purpose;
      adddescript.value = inquryResponse.collateral.adddescript;
      value.value = inquryResponse.collateral.value;
      expenses.value = inquryResponse.additionalInfo.expenses;
      income.value = inquryResponse.additionalInfo.income;
      asset.value = inquryResponse.additionalInfo.asset;
      installment.value = inquryResponse.additionalInfo.installment;

      collateralProofs.add(CollateralProofModel(
        date: inquryResponse.application.trxDate.toString(),
        location: inquryResponse.sectorCity,
        type: inquryResponse.collateral.documentType,
        imagePath: 'assets/images/sample.png',
      ));
    } catch (e) {
      errorMessage.value = 'Gagal mengambil data: $e';
      print('Error: $e');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}

class CollateralProofModel {
  final String date;
  final String location;
  final String type;
  final String imagePath;
  final String sector_city;

  CollateralProofModel({
    required this.date,
    required this.location,
    required this.type,
    required this.imagePath,
    this.sector_city = '',
  });
}
class InquirySurveyModel {
  final String responseCode;
  final String responseDescription;
  final int cifId;
  final String enikNo;
  final String idLegal;
  final String officeId;
  final String fullName;
  final String sectorCity;
  final String locIdn;
  final String villages;
  final String region;
  final String sector;
  final String village;
  final String scopeVillage;
  final String addressLine1;
  final String phone;
  final String kodePekerjaan;
  final String pekerjaan;
  final String deskripsiPekerjaan;
  final Application application;
  final Collateral collateral;
  final AdditionalInfo additionalInfo;
  final Document document;
  final Status status;
  final List<Collaboration> collaboration;

  InquirySurveyModel({
    required this.responseCode,
    required this.responseDescription,
    required this.cifId,
    required this.enikNo,
    required this.idLegal,
    required this.officeId,
    required this.fullName,
    required this.sectorCity,
    required this.locIdn,
    required this.villages,
    required this.region,
    required this.sector,
    required this.village,
    required this.scopeVillage,
    required this.addressLine1,
    required this.phone,
    required this.kodePekerjaan,
    required this.pekerjaan,
    required this.deskripsiPekerjaan,
    required this.application,
    required this.collateral,
    required this.additionalInfo,
    required this.document,
    required this.status,
    required this.collaboration,
  });

  factory InquirySurveyModel.fromJson(Map<String, dynamic> json) {
    return InquirySurveyModel(
      responseCode: json['responseCode']?.toString() ?? '',
      responseDescription: json['responseDescription']?.toString() ?? '',
      cifId: int.tryParse(json['cif_id']?.toString() ?? '0') ?? 0,
      enikNo: json['enik_no']?.toString() ?? '',
      idLegal: json['id_legal']?.toString() ?? '',
      officeId: json['Office_ID']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      sectorCity: json['sector_city']?.toString() ?? '',
      locIdn: json['loc_idn']?.toString() ?? '',
      villages: json['villages']?.toString() ?? '',
      region: json['region']?.toString() ?? '',
      sector: json['sector']?.toString() ?? '',
      village: json['village']?.toString() ?? '',
      scopeVillage: json['scope_village']?.toString() ?? '',
      addressLine1: json['address_line1']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      kodePekerjaan: json['kode_pekerjaan']?.toString() ?? '',
      pekerjaan: json['pekerjaan']?.toString() ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan']?.toString() ?? '',
      application: Application.fromJson(json['application'] ?? {}),
      collateral: Collateral.fromJson(json['collateral'] ?? {}),
      additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] ?? {}),
      document: Document.fromJson(json['document'] ?? {}),
      status: Status.fromJson(json['status'] ?? {}),
      collaboration: (json['Collaboration'] as List<dynamic>?)
              ?.map((item) => Collaboration.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseDescription': responseDescription,
      'cif_id': cifId,
      'enik_no': enikNo,
      'id_legal': idLegal,
      'Office_ID': officeId,
      'full_name': fullName,
      'sector_city': sectorCity,
      'loc_idn': locIdn,
      'villages': villages,
      'region': region,
      'sector': sector,
      'village': village,
      'scope_village': scopeVillage,
      'address_line1': addressLine1,
      'phone': phone,
      'kode_pekerjaan': kodePekerjaan,
      'pekerjaan': pekerjaan,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
      'application': application.toJson(),
      'collateral': collateral.toJson(),
      'additionalinfo': additionalInfo.toJson(),
      'document': document.toJson(),
      'status': status.toJson(),
      'Collaboration': collaboration.map((item) => item.toJson()).toList(),
    };
  }
}

class Application {
  final String trxSurvey;
  final String trxDate;
  final String applicationNo;
  final String purpose;
  final String plafond;

  Application({
    required this.trxSurvey,
    required this.trxDate,
    required this.applicationNo,
    required this.purpose,
    required this.plafond,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      trxSurvey: json['trx_survey'] ?? '',
      trxDate: json['trx_date'] ?? '',
      applicationNo: json['application_no'] ?? '',
      purpose: json['purpose'] ?? '',
      plafond: json['plafond'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trx_survey': trxSurvey,
      'trx_date': trxDate,
      'application_no': applicationNo,
      'purpose': purpose,
      'plafond': plafond,
    };
  }
}

class Collateral {
  final String id;
  final String idName;
  final String adddescript;
  final int idCatDocument;
  final String documentType;
  final String value;

  Collateral({
    required this.id,
    required this.idName,
    required this.adddescript,
    required this.idCatDocument,
    required this.documentType,
    required this.value,
  });

  factory Collateral.fromJson(Map<String, dynamic> json) {
    return Collateral(
      id: json['id'] ?? '',
      idName: json['id_name'] ?? '',
      adddescript: json['adddescript'] ?? '',
      idCatDocument: json['id_catdocument'] ?? 0,
      documentType: json['document_type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_name': idName,
      'adddescript': adddescript,
      'id_catdocument': idCatDocument,
      'document_type': documentType,
      'value': value,
    };
  }
}

class AdditionalInfo {
  final String income;
  final String asset;
  final String expenses;
  final String installment;

  AdditionalInfo({
    required this.income,
    required this.asset,
    required this.expenses,
    required this.installment,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      income: json['income']?.toString() ?? '',
      asset: json['asset']?.toString() ?? '',
      expenses: json['expenses']?.toString() ?? '',
      installment: json['installment']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'income': income,
      'asset': asset,
      'expenses': expenses,
      'installment': installment,
    };
  }
}

class Document {
  final List<DocumentItem> docAsset;
  final List<DocumentItem> docImg;
  final List<DocumentItem> docPerson;

  Document({
    required this.docAsset,
    required this.docImg,
    required this.docPerson,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      docAsset: (json['doc-asset'] as List<dynamic>?)
              ?.map((item) => DocumentItem.fromJson(item))
              .toList() ??
          [],
      docImg: (json['doc-img'] as List<dynamic>?)
              ?.map((item) => DocumentItem.fromJson(item))
              .toList() ??
          [],
      docPerson: (json['doc-person'] as List<dynamic>?)
              ?.map((item) => DocumentItem.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc-asset': docAsset.map((item) => item.toJson()).toList(),
      'doc-img': docImg.map((item) => item.toJson()).toList(),
      'doc-person': docPerson.map((item) => item.toJson()).toList(),
    };
  }
}

class DocumentItem {
  final String img;
  final String doc;

  DocumentItem({
    required this.img,
    required this.doc,
  });

  factory DocumentItem.fromJson(Map<String, dynamic> json) {
    return DocumentItem(
      img: json['img-0'] ?? '',
      doc: json['doc'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img-0': img,
      'doc': doc,
    };
  }
}

class Status {
  final String id;
  final String value;
  final String description;
  final int attachedDocument;
  final String mandatory;

  Status({
    required this.id,
    required this.value,
    required this.description,
    required this.attachedDocument,
    required this.mandatory,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'] ?? '',
      value: json['value'] ?? '',
      description: json['description'] ?? '',
      attachedDocument: json['attachedDocument'] ?? 0,
      mandatory: json['Mandatory'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'description': description,
      'attachedDocument': attachedDocument,
      'Mandatory': mandatory,
    };
  }
}

class Collaboration {
  final String approvalNo;
  final String category;
  final String content;
  final String judgment;
  final String date;
  final String note;

  Collaboration({
    required this.approvalNo,
    required this.category,
    required this.content,
    required this.judgment,
    required this.date,
    required this.note,
  });

  factory Collaboration.fromJson(Map<String, dynamic> json) {
    return Collaboration(
      approvalNo: json['Approval_No'] ?? '',
      category: json['Category'] ?? '',
      content: json['Content'] ?? '',
      judgment: json['Judgment'] ?? '',
      date: json['Date'] ?? '',
      note: json['Note'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Approval_No': approvalNo,
      'Category': category,
      'Content': content,
      'Judgment': judgment,
      'Date': date,
      'Note': note,
    };
  }
}