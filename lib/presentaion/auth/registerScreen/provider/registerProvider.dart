import 'dart:io';
import 'package:flutter/material.dart';
import '../repo/registerRepo.dart';

class RegisterProvider extends ChangeNotifier {
  final RegisterRepository _repository = RegisterRepository();

  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController adharController = TextEditingController();
  TextEditingController vahicalTypeController = TextEditingController();
  TextEditingController vahicalNumberController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController IDProofController = TextEditingController();

  // Images
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
  bool success = false;
  Map<String, dynamic>? driverData;


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

      final response = await _repository.postRegisterApi(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        mobileNo: phoneController.text.trim(),
        address: addressController.text.trim(),
        adharNumber: adharController.text.trim(),
        vehicleType: vahicalTypeController.text.trim(),
        vehicleNumber: vahicalNumberController.text.trim(),
        pincode: pincodeController.text.trim(),
        licenseNumber: licenseController.text.trim(),
        profileImage: profileImage!,
        vehicleRcFrontImage: rcFontImage!,
        vehicleRcBackImage: rcBackImage!,
        idProofImage: idProofImage!,
      );
      if (response.success == true) {
        success = true;
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
