class PutModelsUpdate {
  final int cifId;
  final int idLegal;
  final String officeId;
  final Application application;
  final Collateral collateral;
  final AdditionalInfo additionalInfo;

  PutModelsUpdate({
    required this.cifId,
    required this.idLegal,
    required this.officeId,
    required this.application,
    required this.collateral,
    required this.additionalInfo,
  });

  factory PutModelsUpdate.fromJson(Map<String, dynamic> json) {
    return PutModelsUpdate(
      cifId: json['cif_id'] ?? 0,
      idLegal: json['id_legal'] ?? 0,
      officeId: json['Office_ID'] ?? '',
      application: Application.fromJson(json['application'] ?? {}),
      collateral: Collateral.fromJson(json['collateral'] ?? {}),
      additionalInfo: AdditionalInfo.fromJson(json['additionalinfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cif_id': cifId,
      'id_legal': idLegal,
      'Office_ID': officeId,
      'application': application.toJson(),
      'collateral': collateral.toJson(),
      'additionalinfo': additionalInfo.toJson(),
    };
  }
}

class Application {
  final String trxDate;
  final String trxSurvey;
  final String applicationNo;
  final String purpose;
  final int plafond;

  Application({
    required this.trxDate,
    required this.trxSurvey,
    required this.applicationNo,
    required this.purpose,
    required this.plafond,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      trxDate: json['trx_date'] ?? '',
      trxSurvey: json['trx_survey'] ?? '',
      applicationNo: json['application_no'] ?? '',
      purpose: json['purpose'] ?? '',
      plafond: json['plafond'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trx_date': trxDate,
      'trx_survey': trxSurvey,
      'application_no': applicationNo,
      'purpose': purpose,
      'plafond': plafond,
    };
  }
}

class Collateral {
  final String id;
  final String idName;
  final String addDescript;
  final int idCatDocument;
  final int value;

  Collateral({
    required this.id,
    required this.idName,
    required this.addDescript,
    required this.idCatDocument,
    required this.value,
  });

  factory Collateral.fromJson(Map<String, dynamic> json) {
    return Collateral(
      id: json['id'] ?? '',
      idName: json['id_name'] ?? '',
      addDescript: json['adddescript'] ?? '',
      idCatDocument: json['id_catdocument'] ?? 0,
      value: json['value'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_name': idName,
      'adddescript': addDescript,
      'id_catdocument': idCatDocument,
      'value': value,
    };
  }
}

class AdditionalInfo {
  final int income;
  final int asset;
  final int expenses;
  final int installment;

  AdditionalInfo({
    required this.income,
    required this.asset,
    required this.expenses,
    required this.installment,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      income: json['income'] ?? 0,
      asset: json['asset'] ?? 0,
      expenses: json['expenses'] ?? 0,
      installment: json['installment'] ?? 0,
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