import 'package:json_annotation/json_annotation.dart';

class HistoryResponse {
  String responseCode;
  String responseDescription;
  List<Datum> data;

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
  String idLegal;
  String officeId;
  String fullName;
  String sectorCity;
  String villages;
  String address;
  Status? status;
  Application application;
  Collateral collateral;
  AdditionalInfo additionalInfo;
  Document? document;

  Datum({
    required this.idLegal,
    required this.officeId,
    required this.fullName,
    required this.sectorCity,
    required this.villages,
    required this.address,
    required this.status,
    required this.application,
    required this.collateral,
    required this.additionalInfo,
    this.document,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      idLegal: json['id_legal'] ?? '',
      officeId: json['Office_ID'] ?? '',
      fullName: json['full_name'] ?? '',
      sectorCity: json['sector_city'] ?? '',
      villages: json['village'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      application: Application.fromJson(json['application'] ?? {}),
      collateral: Collateral.fromJson(json['collateral'] ?? {}),
      additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] ?? {}),
      document:
          json['document'] != null ? Document.fromJson(json['document']) : null,
    );
  }
}

class Document {
  List<DocAsset> docAsset;
  List<DocImg> docImg;
  List<DocPerson> docPerson;

  Document({
    required this.docAsset,
    required this.docImg,
    required this.docPerson,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
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
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      income: json['income'] ?? '0',
      asset: json['asset'] ?? '0',
      expenses: json['expenses'] ?? '0',
      installment: json['installment'] ?? '0',
    );
  }
}

class Application {
  String trxSurvey;
  DateTime trxDate;
  String applicationNo;
  String purpose;
  String plafond;

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
      plafond: json['plafond'] ?? '0',
    );
  }
}

class Collateral {
  String id;
  String idName;
  String additionalDescription;
  int idCategoryDocument;
  String documentType;
  String value;

  Collateral({
    required this.id,
    required this.idName,
    required this.additionalDescription,
    required this.idCategoryDocument,
    required this.documentType,
    required this.value,
  });

  factory Collateral.fromJson(Map<String, dynamic> json) {
    return Collateral(
      id: json['id'] ?? '',
      idName: json['id_name'] ?? '',
      additionalDescription: json['adddescript'] ?? '',
      idCategoryDocument: json['id_catdocument'] ?? 0,
      documentType: json['document_type'] ?? '',
      value: json['value'] ?? '0',
    );
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
}
