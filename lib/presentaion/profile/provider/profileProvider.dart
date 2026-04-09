import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profileModel.dart';
import '../repo/profileRepo.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();

  bool loading = false;
  ProfileModel? getProfileData;

  // ✅ Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController IDProofController = TextEditingController();
  TextEditingController adharNumberController = TextEditingController();
  TextEditingController vahicalTypeController = TextEditingController();
  TextEditingController vahicalNumberController = TextEditingController();
  TextEditingController DLNumberController = TextEditingController();

  /// ================= FETCH PROFILE =================
  Future<void> fetchProfileData() async {
    loading = true;
    notifyListeners();

    try {
      getProfileData = await _repo.getProfileApi();
      final data = getProfileData?.data;

      if (data != null) {
        // ✅ Fill controllers from API
        nameController.text = data.name ?? '';
        phoneNumberController.text = data.mobileNo ?? '';
        emailController.text = data.email ?? '';
        addressController.text = data.address ?? '';
        adharNumberController.text = data.adharNumber ?? '';
        vahicalTypeController.text = data.vehicleType ?? '';
        vahicalNumberController.text = data.vehicleNumber ?? '';
        DLNumberController.text = data.licenseNumber ?? '';

        printControllers();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("driverID", data.sId.toString());
      }
    } catch (e) {
      print("Profile API ERROR: $e");
    }

    loading = false;
    notifyListeners();
  }

  void printControllers() {
    print("Name: ${nameController.text}");
    print("Phone: ${phoneNumberController.text}");
    print("Email: ${emailController.text}");
    print("Address: ${addressController.text}");
    print("ID Proof: ${IDProofController.text}");
    print("Aadhar: ${adharNumberController.text}");
    print("Vehicle Type: ${vahicalTypeController.text}");
    print("Vehicle Number: ${vahicalNumberController.text}");
    print("DL Number: ${DLNumberController.text}");
  }

  /// ================= LOCAL FILE IMAGES =================
  File? profileImage;
  File? rcFontImage;
  File? rcBackImage;
  File? idProofImage;

  void setProfileImage(File file) {
    profileImage = file;
    notifyListeners();
  }

  void setRcFrontImage(File file) {
    rcFontImage = file;
    notifyListeners();
  }

  void setRcBackImage(File file) {
    rcBackImage = file;
    notifyListeners();
  }

  // void setIdProofImage(File file) {
  //   idProofImage = file;
  //   notifyListeners();
  // }

  /// ================= IMAGE VALIDATION HELPERS =================
  bool get hasProfileImage {
    final apiImage = getProfileData?.data?.profileImage;
    return profileImage != null || (apiImage != null && apiImage.isNotEmpty);
  }

  bool get hasRcFrontImage {
    final apiImage = getProfileData?.data?.vehicleRcFrontImage;
    return rcFontImage != null || (apiImage != null && apiImage.isNotEmpty);
  }

  bool get hasRcBackImage {
    final apiImage = getProfileData?.data?.vehicleRcBackImage;
    return rcBackImage != null || (apiImage != null && apiImage.isNotEmpty);
  }

  /// ================= SUBMIT STATE =================
  bool isLoading = false;
  String? errorMessage;
  bool success = false;
  Map<String, dynamic>? driverData;

  /// ================= UPDATE PROFILE =================
  Future<void> registerDriver() async {
    errorMessage = null;
    success = false;
    notifyListeners();

    /// ----------- TEXT FIELD VALIDATION -----------
    if (nameController.text.trim().isEmpty) {
      errorMessage = "Please enter name";
      notifyListeners();
      return;
    }

    if (phoneNumberController.text.trim().isEmpty) {
      errorMessage = "Please enter phone number";
      notifyListeners();
      return;
    }

    if (phoneNumberController.text.trim().length != 10) {
      errorMessage = "Phone number must be 10 digits";
      notifyListeners();
      return;
    }

    if (emailController.text.trim().isEmpty) {
      errorMessage = "Please enter email";
      notifyListeners();
      return;
    }

    if (addressController.text.trim().isEmpty) {
      errorMessage = "Please enter address";
      notifyListeners();
      return;
    }

    if (adharNumberController.text.trim().isEmpty) {
      errorMessage = "Please enter Aadhar number";
      notifyListeners();
      return;
    }

    if (adharNumberController.text.trim().length != 12) {
      errorMessage = "Aadhar number must be 12 digits";
      notifyListeners();
      return;
    }

    if (vahicalTypeController.text.trim().isEmpty) {
      errorMessage = "Please enter vehicle type";
      notifyListeners();
      return;
    }

    if (vahicalNumberController.text.trim().isEmpty) {
      errorMessage = "Please enter vehicle number";
      notifyListeners();
      return;
    }

    if (DLNumberController.text.trim().isEmpty) {
      errorMessage = "Please enter DL number";
      notifyListeners();
      return;
    }

    /// ----------- IMAGE VALIDATION -----------
    if (!hasProfileImage) {
      errorMessage = "Please select profile image";
      notifyListeners();
      return;
    }

    if (!hasRcFrontImage) {
      errorMessage = "Please select RC front image";
      notifyListeners();
      return;
    }

    if (!hasRcBackImage) {
      errorMessage = "Please select RC back image";
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final response = await _repo.updateProfile(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        mobileNo: phoneNumberController.text.trim(),
        address: addressController.text.trim(),

        /// ✅ FIXED BUG
        adharNumber: adharNumberController.text.trim(),

        vehicleType: vahicalTypeController.text.trim(),
        vehicleNumber: vahicalNumberController.text.trim(),
        licenseNumber: DLNumberController.text.trim(),

        /// ✅ Only send new selected file if user changed image
        profileImage: profileImage,
        vehicleRcFrontImage: rcFontImage,
        vehicleRcBackImage: rcBackImage,

        // idProofImage: idProofImage,
      );

      if (response.success == true) {
        success = true;
        errorMessage = null;

        /// optional refresh after update
        await fetchProfileData();
      } else {
        errorMessage = response.message ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ================= CLEAR LOCAL PICKED IMAGES (OPTIONAL) =================
  void clearSelectedImages() {
    profileImage = null;
    rcFontImage = null;
    rcBackImage = null;
    idProofImage = null;
    notifyListeners();
  }

  /// ================= DISPOSE =================
  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    addressController.dispose();
    IDProofController.dispose();
    adharNumberController.dispose();
    vahicalTypeController.dispose();
    vahicalNumberController.dispose();
    DLNumberController.dispose();
    super.dispose();
  }
}