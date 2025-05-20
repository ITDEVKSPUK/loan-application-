class CifResponse {
  final String customerUpdate;
  final int cifId;
  final String responseCode;
  final String responseDescription;
  final AdditionalInfo additionalInfo;

  CifResponse({
    required this.customerUpdate,
    required this.cifId,
    required this.responseCode,
    required this.responseDescription,
    required this.additionalInfo,
  });

  factory CifResponse.fromJson(Map<String, dynamic> json) {
    return CifResponse(
      customerUpdate: json['CustomerUpdate'],
      cifId: json['cif_id'],
      responseCode: json['responseCode'],
      responseDescription: json['responseDescription'],
      additionalInfo: AdditionalInfo.fromJson(json['additionalInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerUpdate': customerUpdate,
      'cif_id': cifId,
      'responseCode': responseCode,
      'responseDescription': responseDescription,
      'additionalInfo': additionalInfo.toJson(),
    };
  }
}

class AdditionalInfo {
  final String customerNo;
  final String customerName;

  AdditionalInfo({
    required this.customerNo,
    required this.customerName,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      customerNo: json['customerNo'],
      customerName: json['customerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customerNo': customerNo,
      'customerName': customerName,
    };
  }
}