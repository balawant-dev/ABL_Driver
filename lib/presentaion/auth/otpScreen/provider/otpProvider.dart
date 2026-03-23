import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../mainBottomBar/ui/mainBottomBar.dart';
import '../model/verificationModel.dart';
import '../repo/otpRepo.dart';


class VerifyOtpProvider with ChangeNotifier {
  final _repo = VerifyOtpRepository();
  bool loading = false;
  VerificitionModel? verifyOtpModel;
  final List<TextEditingController> otpControllers =
  List.generate(4, (index) => TextEditingController());
  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }


  // Future<void> verifyOtpProvider(
  //     BuildContext context,
  //     String mobileNumber,
  //     String otp,
  //     ) async {
  //   if (otp.length != 4) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please enter valid 4-digit OTP")),
  //     );
  //     return;
  //   }
  //
  //   loading = true;
  //   notifyListeners();
  //
  //   Map<String, dynamic> data = {
  //     "phone": mobileNumber,
  //     "otp": otp,
  //   };
  //
  //   try {
  //     verifyOtpModel = await _repo.verifyOtpApi(data);
  //
  //     loading = false;
  //     notifyListeners();
  //
  //     if (verifyOtpModel != null && verifyOtpModel!.status == true) {
  //       final token = verifyOtpModel!.token ?? '';
  //
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       if (token.isNotEmpty) {
  //         await prefs.setString('auth_token', token);
  //       }
  //
  //       // Navigator.pushReplacement(
  //       //   context,
  //       //   MaterialPageRoute(builder: (_) => const BottomBarScreen()),
  //       // );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Invalid OTP")),
  //       );
  //     }
  //   } catch (e) {
  //     loading = false;
  //     notifyListeners();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //   }
  // }
  Future<void> verifyOtpProvider(
      BuildContext context,
      String driverId,
      String otp,
      ) async {
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid 4-digit OTP")),
      );
      return;
    }

    loading = true;
    notifyListeners();

    Map<String, dynamic> data = {
      "otp": otp,
      "driverId": driverId,
    };

    try {
      verifyOtpModel = await _repo.verifyOtpApi(data);

      loading = false;
      notifyListeners();

      if (verifyOtpModel != null && verifyOtpModel!.status == true) {
        navPush(context: context, action: MainBottomBar());
        final token = verifyOtpModel!.token ?? '';

        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (token.isNotEmpty) {
          await prefs.setString('auth_token', token);
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid OTP")),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }


}
