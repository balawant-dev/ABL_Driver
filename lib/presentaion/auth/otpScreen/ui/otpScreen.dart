import 'dart:async';

import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/auth/registerScreen/ui/registerScreen.dart';
import 'package:abldriver/presentaion/homeScreen/ui/homeScreen.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../../widget/customInputBox.dart';
import '../../../mainBottomBar/ui/mainBottomBar.dart';
import '../provider/otpProvider.dart';
class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  final String driverId;
  const OtpScreen({super.key,required this.mobileNumber,required this.driverId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController=TextEditingController();
  Timer? _timer;
  int _resendSeconds = 30;
  bool _canResend = true;

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendSeconds = 30;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds == 0) {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      } else {
        setState(() {
          _resendSeconds--;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight =MediaQuery.of(context).size.height;
    final  ScreenWidth =MediaQuery.of(context).size.width;
    return Consumer<VerifyOtpProvider>(
        builder: (context, provider, child){
          return  Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/loginBackground.png',
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.14,
                        ),
                        CustomImageView(
                          imagePath: AppImages.logo,
                          height: screenHeight*0.1555,
                          width: ScreenWidth*0.5,
                        ),
                        SizedBox(
                          height: screenHeight * 0.3,
                        ),
                        CustomText(
                          'We have sent OTP to +91 ${widget.mobileNumber.toString()}',
                          size: 18,
                          color: ColorResource.black,
                          weight: FontWeight.w600,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Pinput(
                                controller: otpController,
                                length: 4,
                                keyboardType: TextInputType.number,
                                autofocus: true,

                                defaultPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  margin: const EdgeInsets.symmetric(horizontal: 10), // 👈 spacing here
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                ),

                                focusedPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFF086B48),
                                      width: 2,
                                    ),
                                  ),
                                ),

                                onCompleted: (pin) {
                                  print('OTP Entered: $pin');
                                },
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: _canResend
                                        ? () {
                                      print('OTP Re-sent');
                                      _startResendTimer();
                                      // 👉 Call resend OTP API here
                                    }
                                        : null,
                                    child: CustomText(
                                      _canResend
                                          ? 'Re-send'
                                          : 'Re-send in $_resendSeconds s',
                                      size: 12,
                                      weight: FontWeight.w600,
                                      color: _canResend
                                          ? ColorResource.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),





                              SizedBox(height: 10,),
                              PrimaryButton(
                                title: provider.loading ? 'Please wait...' : 'Continue',
                                onTap: () {
                                  if (provider.loading) return;

                                  final otp = otpController.text.trim();

                                  context.read<VerifyOtpProvider>().verifyOtpProvider(
                                    context,
                                    widget.driverId,
                                    otp,
                                  );
                                  print("OTP: $otp");
                                  print("Driver ID: ${widget.driverId}");
                                },
                              ),




                              SizedBox(height: 10,),
                              Center(
                                child: CustomText(
                                  "Didn’t receive the OTP SMS?",
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: ColorResource.black,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.05,
                              ),
                              GestureDetector(
                                onTap: (){
                                  navPush(context: context, action: RegisterScreen());
                                },
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Doesn’t have an account ? ',
                                          style: TextStyle(
                                            color: Colors.black.withValues(alpha: 0.50),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                            letterSpacing: 0.32,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Register',
                                          style: TextStyle(
                                            color: const Color(0xFF086B48),
                                            fontSize: 16,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                            letterSpacing: 0.32,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                ),
              )
          );
        }
    );


  }
}
