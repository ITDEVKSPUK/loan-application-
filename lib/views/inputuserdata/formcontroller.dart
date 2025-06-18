import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loan_application/API/models/anggota_models.dart';
import 'package:loan_application/API/models/cif_models.dart';
import 'package:loan_application/API/models/history_models.dart';
import 'package:loan_application/API/service/post_create_CIF.dart';
import 'package:loan_application/API/service/post_history.dart';
import 'package:loan_application/API/service/post_nik_check.dart';
import 'package:loan_application/core/theme/color.dart';
import 'package:loan_application/utils/routes/my_app_route.dart';

class InputDataController extends GetxController {
  // Text Controllers
  final nikController = TextEditingController();
  final selectedGenderController = TextEditingController();
  final nikpasaganController = TextEditingController();
  final namaAwalController = TextEditingController();
  final namaAkhirController = TextEditingController();
  final namaPasanganController = TextEditingController();
  final tanggallahirController = TextEditingController();
  final kotaAsalController = TextEditingController();
  final telpController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final alamatController = TextEditingController();
  final nominalController = TextEditingController();
  final jenisJaminanController = TextEditingController();
  final detileAlamatController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Reactive Variables
  final fotoKtp = Rxn<File>();
  final buktiJaminan = Rxn<File>();
  final selectedGender = ''.obs;
  final startDate = DateTime.now().obs;
  final selectedDateText = ''.obs;
  final selectedDate = ''.obs;
  final isUnmarried = false.obs;
  final isNoFirstName = false.obs;
  final isNikValid = false.obs;
  final isNextButtonEnabled = false.obs;
  final selectedLocationLink = ''.obs;
  final selectedLatitude = 0.0.obs;
  final selectedLongitude = 0.0.obs;
  final isLoading = true.obs;
  final locationServiceEnabled = true.obs;
  final initialPosition = const LatLng(-6.175392, 106.827153).obs; // Default: Jakarta
  final selectedPosition = Rxn<LatLng>();
  final mapController = Rxn<GoogleMapController>();

  final ImagePicker _picker = ImagePicker();
  final RxInt cifResponse = 0.obs;

  @override
  void onClose() {
    // Dispose controllers
    nikController.dispose();
    selectedGenderController.dispose();
    nikpasaganController.dispose();
    namaAwalController.dispose();
    namaAkhirController.dispose();
    namaPasanganController.dispose();
    tanggallahirController.dispose();
    kotaAsalController.dispose();
    telpController.dispose();
    pekerjaanController.dispose();
    alamatController.dispose();
    nominalController.dispose();
    jenisJaminanController.dispose();
    detileAlamatController.dispose();
    postalCodeController.dispose();
    mapController.value?.dispose();
    super.onClose();
  }

  String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd-MMMM-yyyy', 'id_ID').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Future<void> checkLocationServiceAndGetPosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationServiceEnabled.value = false;
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Location services are disabled. Please enable them in settings.',
          backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite,
          mainButton: TextButton(
            onPressed: () => Geolocator.openLocationSettings(),
            child: const Text('Open Settings'),
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            'Location permission denied.',
            backgroundColor: AppColors.redstatus,
            colorText: AppColors.pureWhite,
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Location permission permanently denied. Please enable it in settings.',
          backgroundColor: AppColors.redstatus,
          colorText: AppColors.pureWhite,
          mainButton: TextButton(
            onPressed: () => Geolocator.openLocationSettings(),
            child: const Text('Open Settings'),
          ),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      initialPosition.value = LatLng(position.latitude, position.longitude);
      selectedPosition.value = initialPosition.value;
      isLoading.value = false;
      if (mapController.value != null) {
        mapController.value!.animateCamera(
          CameraUpdate.newLatLng(initialPosition.value),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to get current location: $e',
        backgroundColor: AppColors.redstatus,
        colorText: AppColors.pureWhite,
      );
    }
  }

  void onMapTap(LatLng position) {
    selectedPosition.value = position;
    selectedLatitude.value = position.latitude;
    selectedLongitude.value = position.longitude;
    selectedLocationLink.value =
        'https://maps.google.com/?q=${position.latitude},${position.longitude}';
    detileAlamatController.text = selectedLocationLink.value;
    update();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
    mapController.value!.animateCamera(
      CameraUpdate.newLatLngZoom(initialPosition.value, 15),
    );
  }

  Future<void> fetchNikData() async {
    final nikInput = nikController.text;
    if (nikInput.isEmpty) {
      _showSnackbar('Error', 'NIK field cannot be empty', AppColors.redstatus);
      isNextButtonEnabled.value = false;
      isNikValid.value = false;
      return;
    }

    clearForm();
    nikController.text = nikInput;

    final checkNikService = CheckNik();
    final historyService = HistoryService();

    try {
      final nikResponse = await checkNikService.fetchNIK(nikInput);
      if (nikResponse.data != null &&
          nikResponse.data['responseCode'] == '00') {
        final anggotaResponse = AnggotaResponse.fromJson(nikResponse.data);
        _populateForm(anggotaResponse);
        await _checkLoanHistory(historyService, anggotaResponse);
      } else {
        _showSnackbar('Success', 'NIK belum terdaftar. Silakan lanjutkan.',
            AppColors.casualbutton1);
        isNikValid.value = true;
        isNextButtonEnabled.value = true;
      }
    } catch (e) {
      _showSnackbar('Error', 'Gagal memvalidasi NIK: $e', AppColors.redstatus);
      isNikValid.value = false;
      isNextButtonEnabled.value = false;
    }
  }

  void _populateForm(AnggotaResponse anggotaResponse) {
    setCif(anggotaResponse.owner?.cifId ?? 0);
    namaAwalController.text = anggotaResponse.owner?.firstName ?? '';
    namaAkhirController.text = anggotaResponse.owner?.lastName ?? '';
    namaPasanganController.text = anggotaResponse.owner?.pasanganNama ?? '';
    nikpasaganController.text = anggotaResponse.owner?.pasanganIdcard ?? '';
    tanggallahirController.text =
        formatDate(anggotaResponse.owner?.dateBorn?.toString());
    telpController.text = anggotaResponse.address?.phone ?? '';
    kotaAsalController.text = anggotaResponse.owner?.cityBorn ?? '';
    pekerjaanController.text =
        anggotaResponse.address?.deskripsiPekerjaan ?? '';
    postalCodeController.text = anggotaResponse.address?.postalCode ?? '';
    detileAlamatController.text = anggotaResponse.address?.addressDetile ?? '';
    selectedGender.value = anggotaResponse.owner?.gender?.toString() ?? '';
    alamatController.text = anggotaResponse.address?.sectorCity ?? '';
    isUnmarried.value = anggotaResponse.owner?.pasanganNama == null ||
        anggotaResponse.owner?.pasanganNama == '';
    isNoFirstName.value = anggotaResponse.owner?.firstName == null ||
        anggotaResponse.owner?.firstName == '';
    if (isNoFirstName.value) {
      namaAwalController.text = 'Tidak Memiliki Nama Depan';
    }
  }

  Future<void> _checkLoanHistory(
      HistoryService historyService, AnggotaResponse anggotaResponse) async {
    try {
      final historyResponse = await historyService.fetchHistoryDebitur(
        officeId: '000',
        fromDateTime: DateTime.now().subtract(const Duration(days: 730)),
        toDateTime: DateTime.now(),
      );
      if (historyResponse.statusCode == 200) {
        final historyData = HistoryResponse.fromJson(historyResponse.data);
        final hasLoan = historyData.data.any((datum) =>
            datum.cifID == anggotaResponse.owner?.cifId &&
            datum.application.trxSurvey.isNotEmpty);
        if (hasLoan) {
          _showSnackbar(
              'Error',
              'NIK/CIF sudah memiliki data pinjaman terdaftar.',
              AppColors.redstatus);
          isNikValid.value = false;
          isNextButtonEnabled.value = false;
        } else {
          _showSnackbar(
              'Success',
              'NIK terdaftar tetapi belum memiliki data pinjaman.',
              AppColors.casualbutton1);
          isNikValid.value = true;
          isNextButtonEnabled.value = true;
        }
      } else {
        _showSnackbar(
            'Success',
            'NIK terdaftar tetapi tidak dapat memeriksa data pinjaman.',
            AppColors.casualbutton1);
        isNikValid.value = true;
        isNextButtonEnabled.value = true;
      }
    } catch (e) {
      _showSnackbar('Warning', 'Gagal memeriksa data pinjaman: $e.',
          AppColors.orangestatus);
      isNikValid.value = true;
      isNextButtonEnabled.value = true;
    }
  }

  Future<void> saveForm() async {
    if (!validateForm()) {
      _showSnackbar('Gagal', 'Pastikan semua data terisi termasuk gender',
          AppColors.redstatus);
      return;
    }

    final createCIFService = CreateCIFService();
    try {
      final parts = alamatController.text.split(', ');
      final response = await createCIFService.createCIF(
        idLegal: 3319123456,
        officeId: '000',
        enikNo: nikController.text,
        enikType: 'K05',
        firstName: isNoFirstName.value ? '' : namaAwalController.text,
        lastName: namaAkhirController.text,
        cityBorn: kotaAsalController.text,
        pasanganNama:
            isUnmarried.value ? 'Belum Kawin' : namaPasanganController.text,
        pasanganIdCart: isUnmarried.value ? '0' : nikpasaganController.text,
        region: parts.length > 1 ? parts[1] : '',
        sector: parts.length > 2 ? parts[2] : '',
        village: parts.length > 3 ? parts[3] : '',
        scopeVillage: '004-005',
        addressLine1: detileAlamatController.text,
        pemberiKerja: pekerjaanController.text,
        postalCode: postalCodeController.text,
        deskripsiPekerjaan: pekerjaanController.text,
        phone: telpController.text.replaceAll(RegExp(r'\s'), ''),
      );
      if (response.statusCode == 200) {
        _showSnackbar(
            'Berhasil', 'Data berhasil disimpan', AppColors.casualbutton1);
        final cifResponse = CifResponse.fromJson(response.data);
        setCif(cifResponse.cifId);
      } else {
        _showSnackbar('Gagal', 'Gagal menyimpan data: ${response.statusCode}',
            AppColors.redstatus);
      }
    } catch (e) {
      _showSnackbar('Error', 'Terjadi kesalahan: $e', AppColors.redstatus);
    }
  }

  Future<void> pickImageFromGallery(bool isKtp) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isKtp) {
        fotoKtp.value = File(pickedFile.path);
      } else {
        buktiJaminan.value = File(pickedFile.path);
      }
    }
  }

  void setImageFromCamera(String path, bool isKtp) {
    if (isKtp) {
      fotoKtp.value = File(path);
    } else {
      buktiJaminan.value = File(path);
    }
  }

  void clearForm() {
    selectedGender.value = '';
    namaAwalController.clear();
    namaAkhirController.clear();
    namaPasanganController.clear();
    tanggallahirController.clear();
    kotaAsalController.clear();
    nikpasaganController.clear();
    telpController.clear();
    pekerjaanController.clear();
    postalCodeController.clear();
    alamatController.clear();
    nominalController.clear();
    jenisJaminanController.clear();
    detileAlamatController.clear();
    fotoKtp.value = null;
    buktiJaminan.value = null;
    isUnmarried.value = false;
    isNoFirstName.value = false;
    isNikValid.value = false;
    isNextButtonEnabled.value = false;
    startDate.value = DateTime.now();
    selectedDateText.value = '';
    selectedDate.value = '';
    selectedLocationLink.value = '';
    selectedLatitude.value = 0.0;
    selectedLongitude.value = 0.0;
    isLoading.value = true;
    locationServiceEnabled.value = true;
    selectedPosition.value = null;
    mapController.value = null;
    cifResponse.value = 0;
    update();
  }

  void setCif(int data) {
    cifResponse.value = data;
  }

  int? get cifId => cifResponse.value;

  bool validateForm() {
    if (nikController.text.isEmpty ||
        (namaAwalController.text.isEmpty && !isNoFirstName.value) ||
        selectedGender.value.isEmpty) {
      _showSnackbar('Error', 'Pastikan semua data terisi termasuk gender',
          AppColors.redstatus);
      return false;
    }
    final cleanedPhone = telpController.text.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\+\d+$').hasMatch(cleanedPhone)) {
      _showSnackbar(
          'Error',
          'Nomor telepon harus diawali dengan "+" dan hanya berisi angka',
          AppColors.redstatus);
      return false;
    }
    return true;
  }

  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDate.value = picked;
      tanggallahirController.text =
          DateFormat('dd-MMMM-yyyy', 'id_ID').format(picked);
    }
  }

  Future<void> handleNextButton() async {
    if (!validateForm()) {
      _showSnackbar(
          'Error', 'Harap isi semua kolom dengan benar.', AppColors.redstatus);
      return;
    }
    if (!isNikValid.value) {
      _showSnackbar(
          'Error',
          'NIK/CIF belum diperiksa atau sudah memiliki data pinjaman.',
          AppColors.redstatus);
      return;
    }
    await saveForm();
    clearForm();
    Get.toNamed(MyAppRoutes.dataPinjaman);
  }

  void toggleUnmarried(bool? value) {
    isUnmarried.value = value ?? false;
    if (isUnmarried.value) {
      namaPasanganController.text = 'Belum Kawin';
      nikpasaganController.text = '0';
    } else {
      namaPasanganController.clear();
      nikpasaganController.clear();
    }
    update();
  }

  void toggleNoFirstName(bool? value) {
    isNoFirstName.value = value ?? false;
    if (isNoFirstName.value) {
      namaAwalController.text = 'Tidak Memiliki Nama Depan';
    } else {
      namaAwalController.clear();
    }
    update();
  }

  void _showSnackbar(String title, String message, Color backgroundColor) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: AppColors.pureWhite,
    );
  }

  Future<void> navigateToGoogleMaps() async {
    try {
      print('Navigating to /detail_maps...');
      await checkLocationServiceAndGetPosition(); // Initialize location
      final result = await Get.toNamed('/detail_maps');
      print('Navigation result: $result');
      if (result is Map<String, dynamic>) {
        selectedLatitude.value = result['latitude'] as double;
        selectedLongitude.value = result['longitude'] as double;
        selectedLocationLink.value =
            'https://maps.google.com/?q=${result['latitude']},${result['longitude']}';
        detileAlamatController.text = selectedLocationLink.value;
        update();
      } else {
        print('Unexpected result type: ${result.runtimeType}');
        _showSnackbar(
          'Error',
          'Unexpected result from Google Maps navigation.',
          AppColors.redstatus,
        );
      }
    } catch (e, stackTrace) {
      print('Navigation error: $e\nStack trace: $stackTrace');
      _showSnackbar(
        'Error',
        'Failed to navigate to Google Maps: $e',
        AppColors.redstatus,
      );
    }
    await Geolocator.getCurrentPosition();
  }
}