class AnggotaResponse {
  String? responseCode;
  String? responseDescription;
  Owner? owner;
  Addres? addres;

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
      addres: json["addres"] != null ? Addres.fromJson(json["addres"]) : null,
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

class Addres {
  String? region;
  String? sector;
  String? village;
  String? scopeVillage;
  String? postalCode;
  String? addressLine1;
  String? pemberiKerja;
  String? deskripsiPekerjaan;
  String? kodePekerjaan;
  String? namaPerusahaan;
  String? phone;

  Addres({
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

  factory Addres.fromJson(Map<String, dynamic> json) {
    return Addres(
      region: json["region"] as String?,
      sector: json["sector"] as String?,
      village: json["village"] as String?,
      scopeVillage: json["scope_village"] as String?,
      postalCode: json["postal_code"] as String?,
      addressLine1: json["address_line1"] as String?,
      pemberiKerja: json["pemberi_kerja"] as String?,
      deskripsiPekerjaan: json["deskripsi_pekerjaan"] as String?,
      kodePekerjaan: json["kode_pekerjaan"] as String?,
      namaPerusahaan: json["nama_perusahaan"] as String?,
      phone: json["phone"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "region": region,
      "sector": sector,
      "village": village,
      "scope_village": scopeVillage,
      "postal_code": postalCode,
      "address_line1": addressLine1,
      "pemberi_kerja": pemberiKerja,
      "deskripsi_pekerjaan": deskripsiPekerjaan,
      "kode_pekerjaan": kodePekerjaan,
      "nama_perusahaan": namaPerusahaan,
      "phone": phone,
    };
  }
}

class Owner {
  String? enikNo;
  int? cifId;
  String? fullName;
  String? firtsName;
  String? lastName;
  String? cityBorn;
  String? pasanganNama;
  String? pasanganIdcard;
  DateTime? dateBorn;
  int? gender;

  Owner({
    this.enikNo,
    this.cifId,
    this.fullName,
    this.firtsName,
    this.lastName,
    this.cityBorn,
    this.pasanganNama,
    this.pasanganIdcard,
    this.dateBorn,
    this.gender,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      enikNo: json["enik_no"] as String?,
      cifId: json["cif_id"] as int?,
      fullName: json["full_name"] as String?,
      firtsName: json["firts_name"] as String?,
      lastName: json["last_name"] as String?,
      cityBorn: json["city_born"] as String?,
      pasanganNama: json["pasangan_nama"] as String?,
      pasanganIdcard: json["pasangan_idcard"] as String?,
      dateBorn:
          json["date_born"] != null ? DateTime.parse(json["date_born"]) : null,
      gender: json["gender"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "enik_no": enikNo,
      "cif_id": cifId,
      "full_name": fullName,
      "firts_name": firtsName,
      "last_name": lastName,
      "city_born": cityBorn,
      "pasangan_nama": pasanganNama,
      "pasangan_idcard": pasanganIdcard,
      "date_born": dateBorn?.toIso8601String(),
      "gender": gender,
    };
  }
}
