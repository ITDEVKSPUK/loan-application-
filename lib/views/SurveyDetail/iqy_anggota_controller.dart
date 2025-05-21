import 'package:get/get.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';
import 'package:loan_application/API/service/post_inquiry_anggota.dart';
import 'package:intl/intl.dart'; // Tambahkan untuk format tanggal

class IqyAnggotaController extends GetxController {
  var full_name = ''.obs;
  var enik_no = ''.obs;
  var phone = ''.obs;
  var address_line1 = ''.obs;
  var sector_city = ''.obs;
  var date_born = ''.obs;
  var gender = ''.obs;
  var pasangan_nama = ''.obs;
  var deskripsiPekerjaan = ''.obs;
  var trx_survey = ''.obs;
  var inquiryModel = Rxn<InquiryAnggota>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Formatter untuk tanggal lahir (DD-MMMM-YYYY, contoh: 12-Oktober-2025)
  String formatDate(String? date_born) {
    if (date_born == null || date_born.isEmpty) {
      return 'Tidak Ada';
    }

    try {
      // Coba parsing manual jika mengandung "T"
      final DateTime parsedDate = date_born.contains('T')
          ? DateTime.parse(date_born)
          : DateFormat('yyyy-MM-dd').parse(date_born);

      // Format ke dalam Bahasa Indonesia
      final DateFormat formatter = DateFormat('dd-MMMM-yyyy', 'id_ID');
      return formatter.format(parsedDate);
    } catch (e) {
      print('Error saat format tanggal: $e');
      return date_born;
    }
  }

  // Formatter untuk gender (1 = Laki-laki, 0 = Perempuan)
  String formatGender(String gender) {
    if (gender == '1') {
      return 'Laki-laki';
    } else if (gender == '0') {
      return 'Perempuan';
    } else {
      return gender.isEmpty
          ? 'Tidak Ada'
          : gender; // Kembali ke nilai asli jika tidak valid
    }
  }

  void getSurveyListanggota({required String id_search}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquiryAnggota = Post_anggota();

    try {
      final InquiryAnggota = await inquiryAnggota.fetchInquryanggota(
        idLegal: '3319123456',
        officeId: '000',
        idSearch: id_search,
      );

      inquiryModel.value = InquiryAnggota;
      full_name.value = InquiryAnggota.owner.fullName;
      enik_no.value = InquiryAnggota.owner.enikNo;
      phone.value = InquiryAnggota.address.phone.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.address.phone;
      address_line1.value = InquiryAnggota.address.addressLine1;
      sector_city.value = InquiryAnggota.address.sectorCity;
      date_born.value = formatDate(InquiryAnggota.owner.dateBorn);
      gender.value = formatGender(
          InquiryAnggota.owner.gender); // Terapkan formatter gender
      pasangan_nama.value = InquiryAnggota.owner.pasanganNama.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.owner.pasanganNama;
      trx_survey.value = InquiryAnggota.owner.cifId.toString();
      deskripsiPekerjaan.value = InquiryAnggota.owner.deskripsiPekerjaan.isEmpty
          ? InquiryAnggota.address.deskripsiPekerjaan.isEmpty
              ? 'Tidak Ada'
              : InquiryAnggota.address.deskripsiPekerjaan
          : InquiryAnggota.owner.deskripsiPekerjaan;
    } catch (e, stackTrace) {
      errorMessage.value = 'Gagal mengambil data: $e';
      print('Error fetching inquiry: $e');
      print('Stack trace: $stackTrace');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
