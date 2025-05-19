class AnggotaResponse {
  String? responseCode;
  String? responseDescription;
  Owner? owner;
  Address? addres;

  AnggotaResponse({
    this.responseCode,
    this.responseDescription,
    this.owner,
    this.addres,
  });

  factory AnggotaResponse.fromJson(Map<String, dynamic> json) {
    return AnggotaResponse(
      responseCode: json["responseCode"] as String?,
      responseDescription: json["responseDescription"] as String?,
      owner: json["owner"] != null ? Owner.fromJson(json["owner"]) : null,
      addres: json["addres"] != null ? Address.fromJson(json["addres"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "responseCode": responseCode,
      "responseDescription": responseDescription,
      "owner": owner?.toJson(),
      "addres": addres?.toJson(),
    };
  }
}

class Address {
  String? addressType;        
  String? addressLine1;
  String? addressLine2;
  String? region;              
  String? sector;            
  String? village;             
  String? scopeVillage;        
  String? postalCode;
  String? city;
  String? country;
  String? phone;
  String? employer;
  String? jobTitle;
  String? companyName;
  String? jobSector;
  String? jobCode;

  Address({
    this.addressType,
    this.addressLine1,
    this.addressLine2,
    this.region,
    this.sector,
    this.village,
    this.scopeVillage,
    this.postalCode,
    this.city,
    this.country,
    this.phone,
    this.employer,
    this.jobTitle,
    this.companyName,
    this.jobSector,
    this.jobCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressType: json["address_type"],
      addressLine1: json["address_line1"],
      addressLine2: json["address_line2"],
      region: json["region"],
      sector: json["sector"],
      village: json["village"],
      scopeVillage: json["scope_village"],
      postalCode: json["postal_code"],
      city: json["city"],
      country: json["country"],
      phone: json["phone"],
      employer: json["employer"],
      jobTitle: json["job_title"],
      companyName: json["company_name"],
      jobSector: json["job_sector"],
      jobCode: json["job_code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address_type": addressType,
      "address_line1": addressLine1,
      "address_line2": addressLine2,
      "region": region,
      "sector": sector,
      "village": village,
      "scope_village": scopeVillage,
      "postal_code": postalCode,
      "city": city,
      "country": country,
      "phone": phone,
      "employer": employer,
      "job_title": jobTitle,
      "company_name": companyName,
      "job_sector": jobSector,
      "job_code": jobCode,
    };
  }
}


class Owner {
  String? enikNo;
  int? cifId;
  String? fullName;
  String? firstName;
  String? lastName;
  String? placeOfBirth;
  String? dateOfBirth;
  int? gender;
  String? idCardNumber;
  String? motherName;
  String? email;
  String? nationality;
  String? religion;
  String? maritalStatus;
  String? spouseName;
  String? spouseIdCard;
  String? occupation;
  String phone;
  String deskripsiPekerjaan;

  Owner({
    this.enikNo,
    this.cifId,
    this.fullName,
    this.firstName,
    this.lastName,
    this.placeOfBirth,
    this.dateOfBirth,
    this.gender,
    this.idCardNumber,
    this.motherName,
    this.email,
    this.nationality,
    this.religion,
    this.maritalStatus,
    this.spouseName,
    this.spouseIdCard,
    this.occupation,
    required this.phone,
    required this.deskripsiPekerjaan,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      enikNo: json["enik_no"],
      cifId: json["cif_id"],
      fullName: json["full_name"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      placeOfBirth: json["place_of_birth"],
      dateOfBirth: json["date_of_birth"],
      gender: json["gender"],
      idCardNumber: json["id_card_number"],
      motherName: json["mother_name"],
      email: json["email"],
      nationality: json["nationality"],
      religion: json["religion"],
      maritalStatus: json["marital_status"],
      spouseName: json["spouse_name"],
      spouseIdCard: json["spouse_id_card"],
      occupation: json["occupation"],
      phone: json['phone'] ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enik_no": enikNo,
      "cif_id": cifId,
      "full_name": fullName,
      "first_name": firstName,
      "last_name": lastName,
      "place_of_birth": placeOfBirth,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "id_card_number": idCardNumber,
      "mother_name": motherName,
      "phone": phone,
      "email": email,
      "nationality": nationality,
      "religion": religion,
      "marital_status": maritalStatus,
      "spouse_name": spouseName,
      "spouse_id_card": spouseIdCard,
      "occupation": occupation,
    };
  }
}


