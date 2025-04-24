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
  Application application;
  Collateral collateral;
  AdditionalInfo additionalInfo;

  Datum({
    required this.idLegal,
    required this.officeId,
    required this.fullName,
    required this.sectorCity,
    required this.villages,
    required this.address,
    required this.application,
    required this.collateral,
    required this.additionalInfo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      idLegal: json['id_legal'] ?? '',
      officeId: json['Office_ID'] ?? '',
      fullName: json['full_name'] ?? '',
      sectorCity: json['sector_city'] ?? '',
      villages: json['village'] ?? '',
      address: json['address'] ?? '',
      application: Application.fromJson(json['application'] ?? {}),
      collateral: Collateral.fromJson(json['collateral'] ?? {}),
      additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] ?? {}),
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
      trxDate:
          DateTime.parse(json['trx_date'] ?? DateTime.now().toIso8601String()),
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
