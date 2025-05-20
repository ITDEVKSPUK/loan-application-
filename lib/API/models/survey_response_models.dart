class SurveyResponse {
  final String responseCode;
  final String responseDescription;
  final int cifId;
  final String trxIdx;

  SurveyResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.cifId,
    required this.trxIdx,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) {
    return SurveyResponse(
      responseCode: json['responseCode'] as String,
      responseDescription: json['responseDescription'] as String,
      cifId: json['cif_id'] as int,
      trxIdx: json['trx_idx'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseDescription': responseDescription,
      'cif_id': cifId,
      'trx_idx': trxIdx,
    };
  }
}
