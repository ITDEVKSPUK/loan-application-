class InquiryAnggota {
  final String responseCode;
  final String responseDescription;
  final Owner owner;
  final Address address;

  InquiryAnggota({
    required this.responseCode,
    required this.responseDescription,
    required this.owner,
    required this.address,
  });

  factory InquiryAnggota.fromJson(Map<String, dynamic> json) {
    return InquiryAnggota(
      responseCode: json['responseCode']?.toString() ?? '',
      responseDescription: json['responseDescription']?.toString() ?? '',
      owner: Owner.fromJson(json['owner'] ?? {}),
      address: Address.fromJson(json['address'] ?? json['addres'] ?? {}),
    );
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
  final String pasanganIdCard;
  final String dateBorn;
  final String gender;
  final String deskripsiPekerjaan;

  Owner({
    required this.enikNo,
    required this.cifId,
    required this.fullName,
    required this.firstName,
    required this.lastName,
    required this.cityBorn,
    required this.pasanganNama,
    required this.pasanganIdCard,
    required this.dateBorn,
    required this.gender,
    required this.deskripsiPekerjaan,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      enikNo: json['enik_no']?.toString() ?? '',
      cifId: int.tryParse(json['cif_id']?.toString() ?? '0') ?? 0,
      fullName: json['full_name']?.toString() ?? '',
      firstName: json['firts_name']?.toString() ?? json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      cityBorn: json['city_born']?.toString() ?? '',
      pasanganNama: json['pasangan_nama']?.toString() ?? '',
      pasanganIdCard: json['pasangan_idcard']?.toString() ?? '',
      dateBorn: json['date_born']?.toString() ?? '',
      gender: (json['gender'] ?? 0).toString(), // Pastikan int dikonversi ke String
      deskripsiPekerjaan: json['deskripsi_pekerjaan']?.toString() ?? '',
    );
  }
}
class Address {
  final String sectorCity;
  final String locIdn;
  final String villages;
  final String region;
  final String sector;
  final String village;
  final String scopeVillage;
  final String postalCode;
  final String addressLine1;
  final String pemberiKerja;
  final String deskripsiPekerjaan;
  final String namaPerusahaan;
  final String phone;

  Address({
    required this.sectorCity,
    required this.locIdn,
    required this.villages,
    required this.region,
    required this.sector,
    required this.village,
    required this.scopeVillage,
    required this.postalCode,
    required this.addressLine1,
    required this.pemberiKerja,
    required this.deskripsiPekerjaan,
    required this.namaPerusahaan,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      sectorCity: json['sector_city']?.toString() ?? '',
      locIdn: json['loc_idn']?.toString() ?? '',
      villages: json['villages']?.toString() ?? '',
      region: json['region']?.toString() ?? '',
      sector: json['sector']?.toString() ?? '',
      village: json['village']?.toString() ?? '',
      scopeVillage: json['scope_village']?.toString() ?? '',
      postalCode: json['postal_code']?.toString() ?? '',
      addressLine1: json['address_line1']?.toString() ?? '',
      pemberiKerja: json['pemberi_kerja']?.toString() ?? '',
      deskripsiPekerjaan: json['deskripsi_pekerjaan']?.toString() ?? '',
      namaPerusahaan: json['nama_perusahaan']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
    );
  }
}