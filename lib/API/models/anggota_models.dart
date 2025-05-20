class AnggotaResponse {
  final String responseCode;
  final String responseDescription;
  final Owner? owner;
  final Address? address;

  AnggotaResponse({
    required this.responseCode,
    required this.responseDescription,
    this.owner,
    this.address,
  });

  factory AnggotaResponse.fromJson(Map<String, dynamic> json) {
    return AnggotaResponse(
      responseCode: json['responseCode'] ?? '',
      responseDescription: json['responseDescription'] ?? '',
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      address: json['addres'] != null ? Address.fromJson(json['addres']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseDescription': responseDescription,
      'owner': owner?.toJson(),
      'addres': address?.toJson(),
    };
  }
}

class Owner {
  final String? enikNo;
  final int? cifId;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? cityBorn;
  final String? pasanganNama;
  final String? pasanganIdcard;
  final DateTime? dateBorn;
  final int? gender;
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
    this.cityBorn,
    this.pasanganNama,
    this.pasanganIdcard,
    this.dateBorn,
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
      enikNo: json['enik_no'] ?? '',
      cifId: json['cif_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      firstName: json['firts_name'] ?? '',
      lastName: json['last_name'] ?? '',
      cityBorn: json['city_born'] ?? '',
      pasanganNama: json['pasangan_nama'] ?? '',
      pasanganIdcard: json['pasangan_idcard'] ?? '',
      dateBorn: json['date_born'] != null
          ? DateTime.tryParse(json['date_born'])
          : null,
      gender: json['gender'] ?? 0,
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
      'enik_no': enikNo,
      'cif_id': cifId,
      'full_name': fullName,
      'firts_name': firstName,
      'last_name': lastName,
      'city_born': cityBorn,
      'pasangan_nama': pasanganNama,
      'pasangan_idcard': pasanganIdcard,
      'date_born': dateBorn?.toIso8601String(),
      'gender': gender,
    };
  }
}

class Address {
  final String? region;
  final String? sector;
  final String? village;
  final String? scopeVillage;
  final String? postalCode;
  final String? addressLine1;
  final String? pemberiKerja;
  final String? deskripsiPekerjaan;
  final String? kodePekerjaan;
  final String? namaPerusahaan;
  final String? phone;

  Address({
    this.region,
    this.sector,
    this.village,
    this.scopeVillage,
    this.postalCode,
    this.addressLine1,
    this.pemberiKerja,
    this.deskripsiPekerjaan,
    this.kodePekerjaan,
    this.namaPerusahaan,
    this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      region: json['region'] ?? '',
      sector: json['sector'] ?? '',
      village: json['village'] ?? '',
      scopeVillage: json['scope_village'] ?? '',
      postalCode: json['postal_code'] ?? '',
      addressLine1: json['address_line1'] ?? '',
      pemberiKerja: json['pemberi_kerja'] ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan'] ?? '',
      kodePekerjaan: json['kode_pekerjaan'] ?? '',
      namaPerusahaan: json['nama_perusahaan'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'region': region,
      'sector': sector,
      'village': village,
      'scope_village': scopeVillage,
      'postal_code': postalCode,
      'address_line1': addressLine1,
      'pemberi_kerja': pemberiKerja,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
      'kode_pekerjaan': kodePekerjaan,
      'nama_perusahaan': namaPerusahaan,
      'phone': phone,
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
