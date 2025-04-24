import 'package:get/get.dart';
import 'package:loan_application/API/service/get_location.dart';

class LocationController extends GetxController {
  var provinces = [].obs;
  var regencies = [].obs;
  var districts = [].obs;
  var villages = [].obs;

  var selectedProvinceId = ''.obs;
  var selectedRegencyId = ''.obs;
  var selectedDistrictId = ''.obs;
  var selectedVillageId = ''.obs;

  @override
  void onInit() {
    fetchProvinces();
    super.onInit();
  }

  void fetchProvinces() async {
    try {
      final data = await getlocation.fetchProvinces();
      provinces.value = data;

      print(">>> Province List IDs: ${data.map((e) => e['pro_idn']).toList()}");
      print(">>> Current selectedProvinceId: ${selectedProvinceId.value}");
    } catch (e) {
      print('Error fetching provinces: $e');
    }
  }

  void fetchRegencies(String provinceId) async {
    // Simpan ID provinsi yang dipilih
    selectedProvinceId.value = provinceId;

    // Reset pilihan yang ada sebelumnya
    selectedRegencyId.value = '';
    selectedDistrictId.value = '';
    selectedVillageId.value = '';

    // Fetch kabupaten berdasarkan provinsi baru
    regencies.value = await getlocation.fetchRegencies(provinceId);

    // Kosongkan kecamatan dan desa
    districts.clear();
    villages.clear();
  }

  void fetchDistricts(String regencyId) async {
    selectedRegencyId.value = regencyId;

    // Reset ID kecamatan dan desa
    selectedDistrictId.value = '';
    selectedVillageId.value = '';

    districts.value = await getlocation.fetchDistricts(regencyId);
    villages.clear();
  }

  void fetchVillages(String districtId) async {
    selectedDistrictId.value = districtId;

    // Reset desa sebelumnya
    selectedVillageId.value = '';

    villages.value = await getlocation.fetchVillages(districtId);
  }

  void resetAll() {}
}
