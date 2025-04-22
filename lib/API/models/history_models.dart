class HistoryResponse {
  final String responseCode;
  final String responseDescription;
  final List<HistoryModel> data;

  HistoryResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => HistoryModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class HistoryModel {
  final int cifId;
  final num idLegal;
  final String officeId;
  final String fullName;
  final String region;
  final String sector;
  final String village;
  final String scopeVillage;
  final String address;
  final Application application;
  final Collateral collateral;
  final AdditionalInfo additionalInfo;

  HistoryModel({
    required this.cifId,
    required this.idLegal,
    required this.officeId,
    required this.fullName,
    required this.region,
    required this.sector,
    required this.village,
    required this.scopeVillage,
    required this.address,
    required this.application,
    required this.collateral,
    required this.additionalInfo,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      cifId: json['cif_id'] as int,
      idLegal: json['id_legal'] as num,
      officeId: json['Office_ID'] as String,
      fullName: json['full_name'] as String,
      region: json['region'] as String,
      sector: json['sector'] as String,
      village: json['village'] as String,
      scopeVillage: json['scope_village'] as String,
      address: json['address'] as String,
      application: Application.fromJson(json['application'] as Map<String, dynamic>),
      collateral: Collateral.fromJson(json['collateral'] as Map<String, dynamic>),
      additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] as Map<String, dynamic>),
    );
  }
}

class Application {
  final String trxSurvey;
  final String trxDate;
  final String applicationNo;
  final String purpose;
  final num plafond;

  Application({
    required this.trxSurvey,
    required this.trxDate,
    required this.applicationNo,
    required this.purpose,
    required this.plafond,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      trxSurvey: json['trx_survey'] as String,
      trxDate: json['trx_date'] as String,
      applicationNo: json['application_no'] as String,
      purpose: json['purpose'] as String,
      plafond: json['plafond'] as num,
    );
  }
}

class Collateral {
  final String id;
  final String idName;
  final String addDescript;
  final int idCatDocument;
  final String documentType;
  final num value;

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
      id: json['id'] as String,
      idName: json['id_name'] as String,
      addDescript: json['adddescript'] as String,
      idCatDocument: json['id_catdocument'] as int,
      documentType: json['document_type'] as String,
      value: json['value'] as num,
    );
  }
}

class AdditionalInfo {
  final num income;
  final num asset;
  final num expenses;
  final num installment;

  AdditionalInfo({
    required this.income,
    required this.asset,
    required this.expenses,
    required this.installment,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      income: json['income'] as num,
      asset: json['asset'] as num,
      expenses: json['expenses'] as num,
      installment: json['installment'] as num,
    );
  }
}
