class LoginModel {
  final String status;
  final String loginName;
  final String userName;
  final AdditionalUser additionalUser;
  final AdditionalInfo additionalInfo;
  final String sessionId;

  LoginModel({
    required this.status,
    required this.loginName,
    required this.userName,
    required this.additionalUser,
    required this.additionalInfo,
    required this.sessionId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      loginName: json['LoginName'],
      userName: json['UserName'],
      additionalUser: AdditionalUser.fromJson(json['additionalUser']),
      additionalInfo: AdditionalInfo.fromJson(json['additionalInfo']),
      sessionId: json['SessionID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'LoginName': loginName,
      'UserName': userName,
      'additionalUser': additionalUser.toJson(),
      'additionalInfo': additionalInfo.toJson(),
      'SessionID': sessionId,
    };
  }
}

class AdditionalUser {
  final String groupId;
  final String groupName;

  AdditionalUser({
    required this.groupId,
    required this.groupName,
  });

  factory AdditionalUser.fromJson(Map<String, dynamic> json) {
    return AdditionalUser(
      groupId: json['GroupId'],
      groupName: json['GroupName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GroupId': groupId,
      'GroupName': groupName,
    };
  }
}

class AdditionalInfo {
  final String ido;
  final String legalName;
  final String legalId;

  AdditionalInfo({
    required this.ido,
    required this.legalName,
    required this.legalId,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      ido: json['Ido'],
      legalName: json['LegalName'],
      legalId: json['Legal_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Ido': ido,
      'LegalName': legalName,
      'Legal_Id': legalId,
    };
  }
}