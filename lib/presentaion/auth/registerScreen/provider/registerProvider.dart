// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../repo/registerRepo.dart';
//
// class RegisterProvider extends ChangeNotifier {
//   final RegisterRepository _repository = RegisterRepository();
//
//   // Controllers
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController adharController = TextEditingController();
//   TextEditingController vahicalTypeController = TextEditingController();
//   TextEditingController vahicalNumberController = TextEditingController();
//   TextEditingController pincodeController = TextEditingController();
//   TextEditingController licenseController = TextEditingController();
//   TextEditingController IDProofController = TextEditingController();
//
//   // Images
//   File? profileImage;
//   File? rcFontImage;
//   File? rcBackImage;
//  // File? idProofImage;
//
//   void setProfileImage(File file) {
//     profileImage = file;
//     notifyListeners();
//   }
//
//   void setRcFrontImage(File file) {
//     rcFontImage = file;
//     notifyListeners();
//   }
//
//   void setRcBackImage(File file) {
//     rcBackImage = file;
//     notifyListeners();
//   }
//
//   // void setIdProofImage(File file) {
//   //   idProofImage = file;
//   //   notifyListeners();
//   // }
//
//   bool isLoading = false;
//   String? errorMessage;
//   bool success = false;
//   Map<String, dynamic>? driverData;
//
//
//   Future<void> registerDriver() async {
//     if (profileImage == null ||
//         rcFontImage == null ||
//         rcBackImage == null
//        // idProofImage == null
//     ) {
//       errorMessage = "Please select all images";
//       notifyListeners();
//       return;
//     }
//
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       final response = await _repository.postRegisterApi(
//         name: nameController.text.trim(),
//         email: emailController.text.trim(),
//         mobileNo: phoneController.text.trim(),
//         address: addressController.text.trim(),
//         adharNumber: adharController.text.trim(),
//         vehicleType: vahicalTypeController.text.trim(),
//         vehicleNumber: vahicalNumberController.text.trim(),
//         pincode: pincodeController.text.trim(),
//         licenseNumber: licenseController.text.trim(),
//         profileImage: profileImage!,
//         vehicleRcFrontImage: rcFontImage!,
//         vehicleRcBackImage: rcBackImage!,
//        // idProofImage: idProofImage!,
//       );
//       if (response.success == true) {
//         success = true;
//       print("jksfbfukbfwbebfuwihf;wbfn");
//      // navPush(context: context, action: LoginScreen());
//
//       } else {
//         errorMessage = response.message;
//       }
//
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }


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

  bool isLoading = false;
  String? errorMessage;
  bool success = false;
  Map<String, dynamic>? driverData;

  // ✅ Field errors
  String? nameError;
  String? phoneError;
  String? emailError;
  String? addressError;
  String? adharError;
  String? vehicleTypeError;
  String? vehicleNumberError;
  String? pincodeError;
  String? licenseError;
  String? imageError;

  // ✅ Clear all errors
  void clearErrors() {
    nameError = null;
    phoneError = null;
    emailError = null;
    addressError = null;
    adharError = null;
    vehicleTypeError = null;
    vehicleNumberError = null;
    pincodeError = null;
    licenseError = null;
    imageError = null;
    errorMessage = null;
  }

  // ✅ Validation method
  bool validateFields() {
    clearErrors();
    bool isValid = true;

    if (nameController.text.trim().isEmpty) {
      nameError = "Name is required";
      isValid = false;
    }

    if (phoneController.text.trim().isEmpty) {
      phoneError = "Phone number is required";
      isValid = false;
    } else if (phoneController.text.trim().length != 10) {
      phoneError = "Phone number must be 10 digits";
      isValid = false;
    }

    if (emailController.text.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text.trim())) {
      emailError = "Enter valid email";
      isValid = false;
    }

    if (addressController.text.trim().isEmpty) {
      addressError = "Address is required";
      isValid = false;
    }

    if (adharController.text.trim().isEmpty) {
      adharError = "Aadhar number is required";
      isValid = false;
    } else if (adharController.text.trim().length != 12) {
      adharError = "Aadhar number must be 12 digits";
      isValid = false;
    }

    if (vahicalTypeController.text.trim().isEmpty) {
      vehicleTypeError = "Vehicle type is required";
      isValid = false;
    }

    if (vahicalNumberController.text.trim().isEmpty) {
      vehicleNumberError = "Vehicle number is required";
      isValid = false;
    }

    if (pincodeController.text.trim().isEmpty) {
      pincodeError = "Pincode is required";
      isValid = false;
    } else if (pincodeController.text.trim().length != 6) {
      pincodeError = "Pincode must be 6 digits";
      isValid = false;
    }

    if (licenseController.text.trim().isEmpty) {
      licenseError = "License number is required";
      isValid = false;
    }

    if (profileImage == null || rcFontImage == null || rcBackImage == null) {
      imageError = "Please select all images";
      isValid = false;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> registerDriver() async {
    success = false;
    errorMessage = null;

    // ✅ FIRST VALIDATE
    if (!validateFields()) {
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
      );

      if (response.success == true) {
        success = true;
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
}