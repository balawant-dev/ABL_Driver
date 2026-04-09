import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../../WebServices/app_url.dart';
import '../../../../WebServices/network/network_api_services.dart';
import '../model/registerModel.dart';

class RegisterRepository {
  final _apiService = NetworkApiServices();

  Future<RegisterModel> postRegisterApi({
    required String name,
    required String email,
    required String mobileNo,
    required String address,
    required String adharNumber,
    required String vehicleType,
    required String vehicleNumber,
    required String pincode,
    required String licenseNumber,

    required File profileImage,
    required File vehicleRcFrontImage,
    required File vehicleRcBackImage,

  }) async {
    final url = AppUrl.driverRegister;

    try {
      final fields = {
        "name": name,
        "email": email,
        "mobileNo": mobileNo,
        "address": address,
        "adharNumber": adharNumber,
        "vehicleType": vehicleType,
        "vehicleNumber": vehicleNumber,
        "pincode": pincode,
        "licenseNumber": licenseNumber,
      };

      final files = {
        "profileImage": profileImage,
        "vehicleRcFrontImage": vehicleRcFrontImage,
        "vehicleRcBackImage": vehicleRcBackImage,
      };

      print("API Response: $url");
      if (kDebugMode) {
        log(" Fields => $fields");
        log(" Files => ${files.keys}");
      }

      final response = await _apiService.postMultipartRegisterApi(
        url: url,
        fields: fields,
        files: files,
      );
      print("API Response: $response");
      return RegisterModel.fromJson(response);
    } catch (e) {
      log(" Register API Error => $e");
      rethrow;
    }
  }
}
