import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/core/constants/app_images.dart';
import 'package:abldriver/presentaion/auth/login/provider/loginProvider.dart';
import 'package:abldriver/presentaion/auth/otpScreen/ui/otpScreen.dart';
import 'package:abldriver/presentaion/auth/registerScreen/ui/registerScreen.dart';
import 'package:abldriver/widget/customImageView.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:abldriver/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/customInputBox.dart';
import 'package:flutter/gestures.dart';

import '../../privacy_policy_screen/privacy_policy_screen.dart';
import '../../privacy_policy_screen/terms_and_condition_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight =MediaQuery.of(context).size.height;
    final  ScreenWidth =MediaQuery.of(context).size.width;
    return Consumer<LoginProvider>(
        builder: (context, provider, child){
          return Container(
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
                          'Please enter Your mobile Number',
                          size: 18,
                          color: ColorResource.black,
                          weight: FontWeight.w600,
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomPhoneInput(
                                controller: provider.mobileController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                              ),
                              SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Checkbox(
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isChecked = value ?? false;
                                          });
                                        },
                                        activeColor: ColorResource.buttonBackground,
                                        checkColor: ColorResource.white,
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(horizontal: 0, vertical: -4), // shrink extra space
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),

                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'By signing up, you agree to our ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Terms of \nUse',
                                          style:  TextStyle(
                                            color: Color(0xFF086B48),
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            height: 1.5,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const TermsAndConditionScreen(title: "Terms and Condition",),
                                                ),
                                              );
                                            },
                                        ),
                                        const TextSpan(
                                          text: ' and ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            height: 1.5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: const TextStyle(
                                            color: Color(0xFF086B48),
                                            fontSize: 12,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            decoration: TextDecoration.underline,
                                            height: 1.5,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const PrivacyPolicyScreen(title: "Privacy Policy",),
                                                ),
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),

                              PrimaryButton(
                                title: provider.loading ? "Sending.." : 'Send OTP',
                                onTap: () {
                                  if (!isChecked) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Please accept Terms & Privacy Policy"),
                                      ),
                                    );
                                    return;
                                  }

                                  if (provider.mobileController.text.isEmpty ||
                                      provider.mobileController.text.length != 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Enter valid mobile number"),
                                      ),
                                    );
                                    return;
                                  }

                                  provider.sendOtpProvider(context);
                                },
                              ),


                              SizedBox(
                                height: screenHeight * 0.07,
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
