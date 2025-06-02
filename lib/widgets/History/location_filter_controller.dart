import 'package:get/get.dart';
import 'package:loan_application/API/service/get_location.dart';
import 'package:loan_application/core/theme/color.dart';

class Location_filterController extends GetxController {
  var provinces = <Map<String, dynamic>>[].obs; // Explicit type
  var regencies = <Map<String, dynamic>>[].obs; // Explicit type
  var districts = <Map<String, dynamic>>[].obs; // Explicit type
  var villages = <Map<String, dynamic>>[].obs; // Explicit type

  var selectedProvinceId = ''.obs;
  var selectedProvinceName = ''.obs;
  var selectedRegencyId = ''.obs;
  var selectedRegencyName = ''.obs;
  var selectedDistrictId = ''.obs;
  var selectedDistrictName = ''.obs;
  var selectedVillageId = ''.obs;
  var selectedVillageName = ''.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchProvinces();
    super.onInit();
  }

  Future<void> fetchProvinces() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final data = await getlocation.fetchProvinces();
      provinces.value = data.cast<Map<String, dynamic>>(); // Cast API response
      print(">>> Province List IDs: ${provinces.map((e) => e['pro_idn']).toList()}");
      print(">>> Current selectedProvinceId: ${selectedProvinceId.value}");
    } catch (e) {
      errorMessage.value = 'Gagal memuat provinsi: $e';
      print('Error fetching provinces: $e');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRegencies(String provinceId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      selectedProvinceId.value = provinceId;
      selectedRegencyId.value = '';
      selectedDistrictId.value = '';
      selectedVillageId.value = '';
      regencies.value = (await getlocation.fetchRegencies(provinceId)).cast<Map<String, dynamic>>();
      districts.clear();
      villages.clear();
    } catch (e) {
      errorMessage.value = 'Gagal memuat kabupaten: $e';
      print('Error fetching regencies: $e');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDistricts(String regencyId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      selectedRegencyId.value = regencyId;
      selectedDistrictId.value = '';
      selectedVillageId.value = '';
      districts.value = (await getlocation.fetchDistricts(regencyId)).cast<Map<String, dynamic>>(); // Cast
      villages.clear();
    } catch (e) {
      errorMessage.value = 'Gagal memuat kecamatan: $e';
      print('Error fetching districts: $e');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
           backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchVillages(String districtId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      selectedDistrictId.value = districtId;
      selectedVillageId.value = '';
      villages.value = (await getlocation.fetchVillages(districtId)).cast<Map<String, dynamic>>();
    } catch (e) {
      errorMessage.value = 'Gagal memuat desa: $e';
      print('Error fetching villages: $e');
      Get.snackbar('Error', errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite);
    } finally {
      isLoading.value = false;
    }
  }

  void resetAll() {
    selectedProvinceId.value = '';
    selectedProvinceName.value = '';
    selectedRegencyId.value = '';
    selectedRegencyName.value = '';
    selectedDistrictId.value = '';
    selectedDistrictName.value = '';
    selectedVillageId.value = '';
    selectedVillageName.value = '';
    provinces.clear();
    regencies.clear();
    districts.clear();
    villages.clear();
    errorMessage.value = '';
    fetchProvinces();
  }
}