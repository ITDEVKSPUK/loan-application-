import 'package:get/get.dart';
import 'package:loan_apllication/API/service/get_location.dart';
import 'package:loan_apllication/API/models/locations/models_location_prov.dart';

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
      final data = await ApiService.fetchProvinces();
      print('Fetched provinces: $data');
      provinces.value = data;
    } catch (e) {
      print('Error fetching provinces: $e');
    }
  }

  void fetchRegencies(String provinceId) async {
    regencies.value = await ApiService.fetchRegencies(provinceId);
    districts.clear();
    villages.clear();
  }

  void fetchDistricts(String regencyId) async {
    districts.value = await ApiService.fetchDistricts(regencyId);
    villages.clear();
  }

  void fetchVillages(String districtId) async {
    villages.value = await ApiService.fetchVillages(districtId);
  }
}
