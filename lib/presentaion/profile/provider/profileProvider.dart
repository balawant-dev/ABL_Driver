import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/profileModel.dart';
import '../repo/profileRepo.dart';


class ProfileProvider with ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();

  bool loading = false;
  ProfileModel? getProfileData;

  // ✅ Controllers here
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController IDProofController = TextEditingController();
  TextEditingController adharNumberController = TextEditingController();
  TextEditingController vahicalTypeController = TextEditingController();
  TextEditingController vahicalNumberController = TextEditingController();
  TextEditingController DLNumberController = TextEditingController();

  Future<void> fetchProfileData() async {
    loading = true;
    notifyListeners();

    try {
      getProfileData = await _repo.getProfileApi();
      final data = getProfileData!.data!;

      // ✅ Fill controllers from API
      nameController.text = data.name ?? '';
      phoneNumberController.text = data.mobileNo ?? '';
      emailController.text = data.email ?? '';
      addressController.text = data.address ?? '';
      //IDProofController.text = data.idProof ?? '';
      adharNumberController.text = data.adharNumber ?? '';
      vahicalTypeController.text = data.vehicleType ?? '';
      vahicalNumberController.text = data.vehicleNumber ?? '';
    DLNumberController.text = data.licenseNumber ?? '';

      // ✅ Print all controller values
      printControllers();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("driverID", data.sId.toString());

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

  void setIdProofImage(File file) {
    idProofImage = file;
    notifyListeners();
  }

  bool isLoading = false;
  String? errorMessage;
  bool success = false;          // 🔹 new
  Map<String, dynamic>? driverData; // 🔹 new


  Future<void> registerDriver() async {
    if (profileImage == null ||
        rcFontImage == null ||
        rcBackImage == null ||
        idProofImage == null) {
      errorMessage = "Please select all images";
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
        adharNumber: addressController.text.trim(),
        vehicleType: vahicalTypeController.text.trim(),
        vehicleNumber: vahicalNumberController.text.trim(),
        licenseNumber: DLNumberController.text.trim(),
        profileImage: profileImage!,
        vehicleRcFrontImage: rcFontImage!,
        vehicleRcBackImage: rcBackImage!,
        idProofImage: idProofImage!,
      );
      if (response.success == true) {
        success = true; // 🔹 new
        print("jksfbfukbfwbebfuwihf;wbfn");
        // navPush(context: context, action: LoginScreen());

      } else {
        errorMessage = response.message;
      }

    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}
