import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:uuid/uuid.dart';

final _secureStorage = FlutterSecureStorage();
final _deviceInfo = DeviceInfoPlugin();
final _networkInfo = NetworkInfo();

Future<Map<String, dynamic>> getDeviceInfo() async {
  // Get or store UUID-based device ID
  String? deviceId = await _secureStorage.read(key: 'device_id');
  if (deviceId == null) {
    final uuid = const Uuid().v4();
    await _secureStorage.write(key: 'device_id', value: uuid);
    deviceId = uuid;
  }

  // Encode device ID (Base64 encoded like backend sample)
  final base64DeviceId = base64.encode(utf8.encode(deviceId));

  // Get IP and MAC (network_info_plus only partially works on desktop)
  final ip = await _networkInfo.getWifiIP() ?? "0.0.0.0";
  final mac = await _networkInfo.getWifiBSSID() ?? "02:00:00:00:00:00";

  // Get platform info
  String platform = Platform.isWindows
      ? "Windows"
      : Platform.isAndroid
          ? "Android"
          : Platform.isIOS
              ? "iOS"
              : "Unknown";

  Map<String, dynamic> devicePayload = {
    "DeviceId": base64DeviceId,
    "IpAddress": ip,
    "MacAddress": mac,
    "Platform": platform,
  };
  print("Device Info Payload: ${jsonEncode(devicePayload)}");
  return devicePayload;
}
