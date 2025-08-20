import 'package:json_annotation/json_annotation.dart';

class HistoryResponse {
  final String responseCode;
  final String responseDescription;
  final List<Datum> data;

  HistoryResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      responseCode: json['responseCode'] ?? '',
      responseDescription: json['responseDescription'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => Datum.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Datum {
  final String idLegal;
  final String officeId;
  final int cifID;
  final String fullName;
  final String aged;
  final String surveyAged;
  final String sectorCity;
  final Application application;
  final Collateral collateral;
  final DocumentDetails? document;
  final Status status;

  Datum({
    required this.cifID,
    required this.idLegal,
    required this.officeId,
    required this.fullName,
    required this.aged,
    required this.surveyAged,
    required this.sectorCity,
    required this.application,
    required this.collateral,
    this.document,
    required this.status,
    required address,
    required villages,
    required AdditionalInfo additionalInfo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
        idLegal: json['id_legal'] ?? '',
        officeId: json['Office_ID'] ?? '',
        fullName: json['full_name'] ?? '',
        aged: json['aged'] ?? '',
        surveyAged: json['surveyaged'] ?? '',
        sectorCity: json['sector_city'] ?? '',
        villages: json['village'] ?? '',
        address: json['address'] ?? '',
        status: json['status'] != null
            ? Status.fromJson(json['status'])
            : Status(id: '', value: ''),
        application: Application.fromJson(json['application'] ?? {}),
        collateral: Collateral.fromJson(json['collateral'] ?? {}),
        additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] ?? {}),
        document: json['document'] != null
            ? DocumentDetails.fromJson(json['document'])
            : null,
        cifID: json['cif_id']);
  }
}

class DocumentDetails {
  List<DocAsset> docAsset;
  List<DocImg> docImg;
  List<DocPerson> docPerson;

  DocumentDetails({
    required this.docAsset,
    required this.docImg,
    required this.docPerson,
  });

  factory DocumentDetails.fromJson(Map<String, dynamic> json) {
    return DocumentDetails(
      docAsset: (json['doc-asset'] as List<dynamic>?)
              ?.map((item) => DocAsset.fromJson(item))
              .toList() ??
          [],
      docImg: (json['doc-img'] as List<dynamic>?)
              ?.map((item) => DocImg.fromJson(item))
              .toList() ??
          [],
      docPerson: (json['doc-person'] as List<dynamic>?)
              ?.map((item) => DocPerson.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class DocAsset {
  @JsonKey(name: 'img-0')
  final String img;
  final String doc;

  DocAsset({
    required this.img,
    required this.doc,
  });

  factory DocAsset.fromJson(Map<String, dynamic> json) {
    return DocAsset(
      img: json['img-0'] ?? '',
      doc: json['doc'] ?? '',
    );
  }
}

class DocImg {
  @JsonKey(name: 'img-0')
  final String img;
  final String doc;

  DocImg({
    required this.img,
    required this.doc,
  });

  factory DocImg.fromJson(Map<String, dynamic> json) {
    return DocImg(
      img: json['img-0'] ?? '',
      doc: json['doc'] ?? '',
    );
  }
}

class DocPerson {
  @JsonKey(name: 'img-0')
  final String img;
  final String doc;

  DocPerson({
    required this.img,
    required this.doc,
  });

  factory DocPerson.fromJson(Map<String, dynamic> json) {
    return DocPerson(
      img: json['img-0'] ?? '',
      doc: json['doc'] ?? '',
    );
  }
}

class AdditionalInfo {
  String income;
  String asset;
  String expenses;
  String installment;

  AdditionalInfo({
    required this.income,
    required this.asset,
    required this.expenses,
    required this.installment,
    DocumentDetails? document,
    required Status status,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      income: json['income'] ?? '0',
      asset: json['asset'] ?? '0',
      expenses: json['expenses'] ?? '0',
      installment: json['installment'] ?? '0',
      document: json['document'] != null
          ? DocumentDetails.fromJson(json['document'])
          : null,
      status: Status.fromJson(json['status'] ?? {}),
    );
  }
}

class Application {
  final String trxSurvey;
  final DateTime trxDate;
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
      trxDate: DateTime.tryParse(json['trx_date'] ?? '') ?? DateTime.now(),
      applicationNo: json['application_no'] ?? '',
      purpose: json['purpose'] ?? '',
      plafond: json['plafond'] ?? '',
    );
  }
}

class Collateral {
  final String id;
  final String idName;
  final String addDescript;
  final int idCatDocument;
  final String documentType;
  final String value;

  Collateral({
    required this.id,
    required this.idName,
    required this.addDescript,
    required this.idCatDocument,
    required this.documentType,
    required this.value,
  });

  factory Collateral.fromJson(Map<String, dynamic> json) {
    return Collateral(
      id: json['id'] ?? '',
      idName: json['id_name'] ?? '',
      addDescript: json['adddescript'] ?? '',
      idCatDocument: json['id_catdocument'] ?? 0,
      documentType: json['document_type'] ?? '',
      value: json['value'] ?? '',
    );
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
}

class Status {
  final String id;
  final String value;
  final String? approved;
  final String? approvedDate;
  final String? description;
  final int? attachedDocument;
  final String? mandatory;
  final String? read;

  Status({
    required this.id,
    required this.value,
    this.approved,
    this.approvedDate,
    this.description,
    this.attachedDocument,
    this.mandatory,
    this.read,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'] ?? '',
      value: json['value'] ?? '',
      approved: json['approved'],
      approvedDate: json['approved_date'],
      description: json['description'],
      attachedDocument: json['attachedDocument'],
      mandatory: json['Mandatory'],
      read: json['read'],
    );
  }
}
