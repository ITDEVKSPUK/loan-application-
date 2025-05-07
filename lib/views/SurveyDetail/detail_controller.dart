import 'package:get/get.dart';
import 'package:loan_application/API/models/history_models.dart';

class DetailController extends GetxController {
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var nik = ''.obs;
  var address = ''.obs;
  var occupation = ''.obs;
  var loanAmount = ''.obs;
  var collateralType = ''.obs;
  var collateralProofs = <CollateralProofModel>[].obs;
  
  @override
  void onInit() {
    super.onInit();

    // Ambil data dari arguments sebagai Datum
    final datum = Get.arguments as Datum;

    // Isi properti berdasarkan data dari Datum
    name.value = datum.fullName;
    phoneNumber.value = ''; // Tambahkan jika ada data nomor telepon
    nik.value = datum.idLegal;
    address.value = datum.address;
    occupation.value = ''; // Tambahkan jika ada data pekerjaan
    loanAmount.value = datum.application.plafond;
    collateralType.value = datum.collateral.documentType;

    // Tambahkan data collateralProofs jika diperlukan
    collateralProofs.add(CollateralProofModel(
      date: datum.application.trxDate.toString(),
      location: datum.sectorCity,
      type: datum.collateral.documentType,
      imagePath: 'assets/images/sample.png', // Ganti dengan path gambar yang sesuai
    ));
  }
}

class CollateralProofModel {
  final String date;
  final String location;
  final String type;
  final String imagePath;

  CollateralProofModel({
    required this.date,
    required this.location,
    required this.type,
    required this.imagePath,
  });
}