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
      'address': address?.toJson(),
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
  final String? idCardNumber;
  final String? motherName;
  final String? email;
  final String? nationality;
  final String? religion;
  final String? maritalStatus;
  final String? spouseName;
  final String? spouseIdCard;
  final String? occupation;
  final String phone;
  final String deskripsiPekerjaan;

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
      idCardNumber: json['id_card_number'] ?? '',
      motherName: json['mother_name'] ?? '',
      email: json['email'] ?? '',
      nationality: json['nationality'] ?? '',
      religion: json['religion'] ?? '',
      maritalStatus: json['marital_status'] ?? '',
      spouseName: json['spouse_name'] ?? '',
      spouseIdCard: json['spouse_id_card'] ?? '',
      occupation: json['occupation'] ?? '',
      phone: json['phone'] ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enik_no': enikNo,
      'cif_id': cifId,
      'full_name': fullName,
      'first_name': firstName,
      'last_name': lastName,
      'city_born': cityBorn,
      'pasangan_nama': pasanganNama,
      'pasangan_idcard': pasanganIdcard,
      'date_born': dateBorn?.toIso8601String(),
      'gender': gender,
      'id_card_number': idCardNumber,
      'mother_name': motherName,
      'email': email,
      'nationality': nationality,
      'religion': religion,
      'marital_status': maritalStatus,
      'spouse_name': spouseName,
      'spouse_id_card': spouseIdCard,
      'occupation': occupation,
      'phone': phone,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
    };
  }
}

class Address {
  final String? sectorCity;
  final String? region;
  final String? sector;
  final String? village;
  final String? scopeVillage;
  final String? postalCode;
  final String? addressDetile;
  final String? mapsUrl;
  final String? pemberiKerja;
  final String? deskripsiPekerjaan;
  final String? kodePekerjaan;
  final String? namaPerusahaan;
  final String? phone;

  Address({
    this.sectorCity,
    this.region,
    this.sector,
    this.village,
    this.scopeVillage,
    this.postalCode,
    this.addressDetile,
    this.mapsUrl,
    this.pemberiKerja,
    this.deskripsiPekerjaan,
    this.kodePekerjaan,
    this.namaPerusahaan,
    this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      sectorCity: json['sector_city'] ?? '',
      region: json['region'] ?? '',
      sector: json['sector'] ?? '',
      village: json['village'] ?? '',
      scopeVillage: json['scope_village'] ?? '',
      postalCode: json['postal_code'] ?? '',
      addressDetile: json['address_line1'] ?? '',
      mapsUrl: json['maps_url'] ?? '',
      pemberiKerja: json['pemberi_kerja'] ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan'] ?? '',
      kodePekerjaan: json['kode_pekerjaan'] ?? '',
      namaPerusahaan: json['nama_perusahaan'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sector_city': sectorCity,
      'region': region,
      'sector': sector,
      'village': village,
      'scope_village': scopeVillage,
      'postal_code': postalCode,
      'address_line1': addressDetile,
      'maps_url': mapsUrl,
      'pemberi_kerja': pemberiKerja,
      'deskripsi_pekerjaan': deskripsiPekerjaan,
      'kode_pekerjaan': kodePekerjaan,
      'nama_perusahaan': namaPerusahaan,
      'phone': phone,
    };
  }
}
