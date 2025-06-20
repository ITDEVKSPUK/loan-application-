import 'package:get/get.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';
import 'package:loan_application/API/service/post_inquiry_anggota.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

class IqyAnggotaController extends GetxController {
  var full_name = ''.obs;
  var enik_no = ''.obs;
  var phone = ''.obs;
  var address_line1 = ''.obs;
  var sector_city = ''.obs;
  var date_born = ''.obs;
  var gender = ''.obs;
  var pasangan_nama = ''.obs;
  var pasangan_idcard = ''.obs;
  var deskripsiPekerjaan = ''.obs;
  var city_born = ''.obs; // Already included for city of birth
  var trx_survey = ''.obs;
  var inquiryModel = Rxn<InquiryAnggota>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var mapsUrl = ''.obs;
  var postal_code = ''.obs;

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

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Tidak Ada';
    }

    // Bersihkan input, hanya ambil digit dan tanda +
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Cek kode negara (1-4 digit)
    final countryCodeMatch = RegExp(r'^\+(\d{1,4})').firstMatch(cleanNumber);
    if (countryCodeMatch == null) {
      return phoneNumber; // Kembalikan asli jika tidak ada kode negara
    }

    // Ambil kode negara dan sisa nomor
    String countryCode = countryCodeMatch.group(0)!; // Misal: +62, +376
    String restOfNumber =
        cleanNumber.substring(countryCode.length); // Sisa nomor // Sisa nomor

    // Jika sisa nomor terlalu pendek, kembalikan tanpa format
    if (restOfNumber.length < 3) {
      return '$countryCode $restOfNumber';
    }

    // Format nomor berdasarkan panjang
    String formattedNumber;
    if (restOfNumber.length >= 10) {
      // Untuk nomor panjang (misal: Indonesia, +62812-345-6789)
      formattedNumber =
          '${restOfNumber.substring(0, 3)}-${restOfNumber.substring(3, 6)}-${restOfNumber.substring(6)}';
    } else if (restOfNumber.length >= 7) {
      // Untuk nomor menengah (misal: Indonesia pendek, +62812-3456)
      formattedNumber =
          '${restOfNumber.substring(0, 3)}-${restOfNumber.substring(3)}';
    } else {
      // Untuk nomor pendek (misal: Andorra, +376123-456)
      formattedNumber =
          '${restOfNumber.substring(0, 3)}-${restOfNumber.substring(3)}';
    }

    // Gabungkan kode negara dan nomor dengan spasi
    return '$countryCode $formattedNumber';
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
      mapsUrl.value = InquiryAnggota.address.mapsUrl;
      postal_code.value = InquiryAnggota.address.postalCode.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.address.postalCode;
      enik_no.value = InquiryAnggota.owner.enikNo;
      phone.value = formatPhoneNumber(InquiryAnggota.address.phone.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.address.phone);
      address_line1.value = InquiryAnggota.address.addressLine1;
      sector_city.value = InquiryAnggota.address.sectorCity;
      date_born.value = formatDate(InquiryAnggota.owner.dateBorn);
      gender.value = formatGender(InquiryAnggota.owner.gender);
      pasangan_nama.value = InquiryAnggota.owner.pasanganNama.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.owner.pasanganNama;
      pasangan_idcard.value = InquiryAnggota.owner.pasanganIdCard.isEmpty
          ? 'Tidak Ada'
          : InquiryAnggota.owner.pasanganIdCard;
      deskripsiPekerjaan.value = InquiryAnggota.owner.deskripsiPekerjaan.isEmpty
          ? InquiryAnggota.address.deskripsiPekerjaan.isEmpty
              ? 'Tidak Ada'
              : InquiryAnggota.address.deskripsiPekerjaan
          : InquiryAnggota.owner.deskripsiPekerjaan;
      // Update city_born value
      city_born.value = InquiryAnggota.owner.cityBorn?.isEmpty ?? true
          ? 'Tidak Ada'
          : InquiryAnggota.owner.cityBorn!;
      trx_survey.value = InquiryAnggota.owner.cifId.toString();
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
