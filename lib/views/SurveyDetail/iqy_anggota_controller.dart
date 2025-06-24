import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';
import 'package:loan_application/API/service/post_inquiry_anggota.dart';
import 'package:intl/intl.dart';

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
  var city_born = ''.obs;
  var trx_survey = ''.obs;
  var inquiryModel = Rxn<InquiryAnggota>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var mapsUrl = ''.obs;
  var postal_code = ''.obs;
  var countryCode = ''.obs;

  String formatDate(String? date_born) {
    if (date_born == null || date_born.isEmpty) {
      return 'Tidak Ada';
    }
    try {
      final DateTime parsedDate = date_born.contains('T')
          ? DateTime.parse(date_born)
          : DateFormat('yyyy-MM-dd').parse(date_born);
      final DateFormat formatter = DateFormat('dd-MMMM-yyyy', 'id_ID');
      return formatter.format(parsedDate);
    } catch (e) {
      print('Error saat format tanggal: $e');
      return date_born;
    }
  }

  String formatGender(String gender) {
    if (gender == '1') {
      return 'Laki-laki';
    } else if (gender == '0') {
      return 'Perempuan';
    } else {
      return gender.isEmpty ? 'Tidak Ada' : gender;
    }
  }

  String formatPhoneNumber(String phoneNumber, String countryCode) {
    if (phoneNumber.isEmpty || phoneNumber == 'Tidak Ada') {
      return 'Tidak Ada';
    }
    // Hapus semua karakter non-digit
    String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    // Hapus '0' di depan jika ada
    if (cleanNumber.startsWith('0')) {
      cleanNumber = cleanNumber.substring(1);
    }
    return '$countryCode $cleanNumber'; // Gabungkan dengan spasi
  }

  void getSurveyListanggota({required String id_search}) async {
    isLoading.value = true;
    errorMessage.value = '';
    final inquiryAnggota = Post_anggota();
    final storage = GetStorage();

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

      // Ambil countryCode dan phone dari GetStorage berdasarkan NIK
      countryCode.value =
          storage.read('countryCode_${InquiryAnggota.owner.enikNo}') ??
              (InquiryAnggota.address.countryCode?.isNotEmpty ?? false
                  ? InquiryAnggota.address.countryCode!
                  : '+62');
      phone.value = storage.read('phone_${InquiryAnggota.owner.enikNo}') ??
          (InquiryAnggota.address.phone.isEmpty
              ? 'Tidak Ada'
              : InquiryAnggota.address.phone);

      // Gabungkan countryCode dan phone dengan spasi
      phone.value = formatPhoneNumber(phone.value, countryCode.value);

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
