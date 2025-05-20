import 'package:get/get.dart';
import 'package:loan_application/API/models/inquiry_anggota_models.dart';
import 'package:loan_application/API/service/post_inquiry_anggota.dart';

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
      date_born.value = InquiryAnggota.owner.dateBorn;
      gender.value = InquiryAnggota.owner.gender;
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
//   }
