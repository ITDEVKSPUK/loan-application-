class KtpModel {
  String? nik;
  String? nama;

  KtpModel({this.nik, this.nama});

  @override
  String toString() {
    return '''
NIK: $nik
Nama: $nama
''';
  }
}
