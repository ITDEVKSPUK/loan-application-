class KtpModel {
  String? nik;
  String? nama;
  String? ttl;
  String? jenisKelamin;
  String? golDarah;
  String? alamat;
  String? rtRw;
  String? kelDesa;
  String? kecamatan;
  String? agama;
  String? statusPerkawinan;
  String? pekerjaan;
  String? kewarganegaraan;
  String? berlakuHingga;

  KtpModel({
    this.nik,
    this.nama,
    this.ttl,
    this.jenisKelamin,
    this.golDarah,
    this.alamat,
    this.rtRw,
    this.kelDesa,
    this.kecamatan,
    this.agama,
    this.statusPerkawinan,
    this.pekerjaan,
    this.kewarganegaraan,
    this.berlakuHingga,
  });

  @override
  String toString() {
    return '''
NIK: $nik
Nama: $nama
TTL: $ttl
Jenis Kelamin: $jenisKelamin
Golongan Darah: $golDarah
Alamat: $alamat
RT/RW: $rtRw
Kel/Desa: $kelDesa
Kecamatan: $kecamatan
Agama: $agama
Status Perkawinan: $statusPerkawinan
Pekerjaan: $pekerjaan
Kewarganegaraan: $kewarganegaraan
Berlaku Hingga: $berlakuHingga
''';
  }
}
