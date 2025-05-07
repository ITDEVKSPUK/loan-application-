class AnggotaResponse {
  final String responseCode;
  final String responseDescription;
  final Owner owner;
  final Address address;

  AnggotaResponse({
    required this.responseCode,
    required this.responseDescription,
    required this.owner,
    required this.address,
  });

  factory AnggotaResponse.fromJson(Map<String, dynamic> json) {
    return AnggotaResponse(
      responseCode: json['responseCode'],
      responseDescription: json['responseDescription'],
      owner: Owner.fromJson(json['owner']),
      address: Address.fromJson(json['addres']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'responseCode': responseCode,
      'responseDescription': responseDescription,
      'owner': owner.toJson(),
      'addres': address.toJson(),
    };
  }
}

class Owner {
  final String enikNo;
  final int cifId;
  final String fullName;
  final String firstName;
  final String lastName;
  final String cityBorn;
  final String pasanganNama;
  final String pasanganIdcard;
  final DateTime dateBorn;
  final int gender;

  Owner({
    required this.enikNo,
    required this.cifId,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.cityBorn,
    required this.pasanganNama,
    required this.pasanganIdcard,
    required this.dateBorn,
    required this.gender,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      enikNo: json['enik_no'],
      cifId: json['cif_id'],
      fullName: json['full_name'],
      firstName: json['firts_name'],
      lastName: json['last_name'],
      cityBorn: json['city_born'],
      pasanganNama: json['pasangan_nama'],
      pasanganIdcard: json['pasangan_idcard'],
      dateBorn: DateTime.parse(json['date_born']),
      gender: json['gender'],
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
      'date_born': dateBorn.toIso8601String(),
      'gender': gender,
    };
  }
}

class Address {
  final String region;
  final String sector;
  final String village;
  final String scopeVillage;
  final String postalCode;
  final String addressLine1;
  final String pemberiKerja;
  final String deskripsiPekerjaan;
  final String kodePekerjaan;
  final String namaPerusahaan;
  final String phone;

  Address({
    required this.region,
    required this.sector,
    required this.village,
    required this.scopeVillage,
    required this.postalCode,
    required this.addressLine1,
    required this.pemberiKerja,
    required this.deskripsiPekerjaan,
    required this.kodePekerjaan,
    required this.namaPerusahaan,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      region: json['region'],
      sector: json['sector'],
      village: json['village'],
      scopeVillage: json['scope_village'],
      postalCode: json['postal_code'],
      addressLine1: json['address_line1'],
      pemberiKerja: json['pemberi_kerja'],
      deskripsiPekerjaan: json['deskripsi_pekerjaan'],
      kodePekerjaan: json['kode_pekerjaan'],
      namaPerusahaan: json['nama_perusahaan'],
      phone: json['phone'],
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
    };
  }
}
