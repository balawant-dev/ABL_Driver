import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/EditProfileModel.dart';
import '../model/profileModel.dart';


class ProfileRepository {
  final _apiService = NetworkApiServices();

  Future<ProfileModel> getProfileApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.getProfile);
      print('response: $response');
      if (response != null) {
        return ProfileModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }



  // Future<EditProfileModel> UpdateProfile({
  //   required String name,
  //   required String email,
  //   required String mobileNo,
  //   required String address,
  //   required String adharNumber,
  //   required String vehicleType,
  //   required String vehicleNumber,
  //   required String licenseNumber,
  //
  //   // Images (4 only)
  //   required File profileImage,
  //   required File vehicleRcFrontImage,
  //   required File vehicleRcBackImage,
  //   required File idProofImage,
  // }) async {
  //   final url = AppUrl.profileUpdate;
  //
  //   try {
  //     final fields = {
  //       "name": name,
  //       "email": email,
  //       "mobileNo": mobileNo,
  //       "address": address,
  //       "adharNumber": adharNumber,
  //       "vehicleType": vehicleType,
  //       "vehicleNumber": vehicleNumber,
  //       "licenseNumber": licenseNumber,
  //     };
  //
  //     final files = {
  //       "profileImage": profileImage,
  //       "vehicleRcFrontImage": vehicleRcFrontImage,
  //       "vehicleRcBackImage": vehicleRcBackImage,
  //       "idProofImage": idProofImage,
  //     };
  //
  //     print("API Response: $url");
  //     if (kDebugMode) {
  //       log("📤 Fields => $fields");
  //       log("🖼 Files => ${files.keys}");
  //     }
  //
  //     final response = await _apiService.postMultipartApiWithToken(
  //       url: url,
  //       fields: fields,
  //       files: files,
  //     );
  //     print("API Response: $response");
  //     return EditProfileModel.fromJson(response);
  //   } catch (e) {
  //     log("❌ Register API Error => $e");
  //     rethrow;
  //   }
  // }

  Future<EditProfileModel> updateProfile({
    required String name,
    required String email,
    required String mobileNo,
    required String address,
    required String adharNumber,
    required String vehicleType,
    required String vehicleNumber,
    required String licenseNumber,

    /// New selected images (can be null)
    File? profileImage,
    File? vehicleRcFrontImage,
    File? vehicleRcBackImage,
    File? idProofImage,

    /// Old image paths from API
    String? oldProfileImage,
    String? oldRcFrontImage,
    String? oldRcBackImage,
    String? oldIdProofImage,
  }) async {
    final url = AppUrl.profileUpdate;

    try {
      final fields = {
        "name": name,
        "email": email,
        "mobileNo": mobileNo,
        "address": address,
        "adharNumber": adharNumber,
        "vehicleType": vehicleType,
        "vehicleNumber": vehicleNumber,
        "licenseNumber": licenseNumber,
      };

      /// If image NOT selected → send old path
      if (profileImage == null && oldProfileImage != null) {
        fields["profileImage"] = oldProfileImage;
      }
      if (vehicleRcFrontImage == null && oldRcFrontImage != null) {
        fields["vehicleRcFrontImage"] = oldRcFrontImage;
      }
      if (vehicleRcBackImage == null && oldRcBackImage != null) {
        fields["vehicleRcBackImage"] = oldRcBackImage;
      }
      if (idProofImage == null && oldIdProofImage != null) {
        fields["idProofImage"] = oldIdProofImage;
      }

      final files = <String, File>{};

      /// If new image selected → send file
      if (profileImage != null) {
        files["profileImage"] = profileImage;
      }
      if (vehicleRcFrontImage != null) {
        files["vehicleRcFrontImage"] = vehicleRcFrontImage;
      }
      if (vehicleRcBackImage != null) {
        files["vehicleRcBackImage"] = vehicleRcBackImage;
      }
      if (idProofImage != null) {
        files["idProofImage"] = idProofImage;
      }

      if (kDebugMode) {
        log("📤 Fields => $fields");
        log("🖼 Files => ${files.keys}");
      }

      /// ✅ PATCH MULTIPART WITH TOKEN
      final response = await _apiService.patchMultipartMultiImageApiWithToken(
        url: url,
        fields: fields,
        files: files,
      );

      return EditProfileModel.fromJson(response);
    } catch (e) {
      log("❌ Update Profile API Error => $e");
      rethrow;
    }
  }

}
