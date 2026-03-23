import 'package:flutter/material.dart';
import '../../../../widget/navigator_method.dart';
import '../../otpScreen/ui/otpScreen.dart';
import '../model/loginModel.dart';
import '../repo/loginrepo.dart';
class LoginProvider with ChangeNotifier {
  final _repo = LoginRepository();
  bool loading = false;
  LoginModel? otpModel;
  TextEditingController mobileController = TextEditingController();
  Future<void> sendOtpProvider(BuildContext context) async {
    String mobile = mobileController.text.trim();
    try {
      loading = true;
      notifyListeners();
      var response = await _repo.sendOtp(mobile);
      print("FULL OTP API RESPONSE: $response");
      otpModel = LoginModel.fromJson(response);
      loading = false;
      notifyListeners();
      if (otpModel?.status == true) {
        print("OTP SUCCESS → ${otpModel?.data?.driverId}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpModel?.message ?? "OTP Sent")),
        );
        navPush(context: context, action: OtpScreen(mobileNumber: mobile,driverId: '${otpModel?.data?.driverId}'));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpModel?.message ?? "Failed to send OTP")),
        );
      }
    } catch (e) {
      loading = false;
      notifyListeners();
      print("OTP API ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    }
  }
}
