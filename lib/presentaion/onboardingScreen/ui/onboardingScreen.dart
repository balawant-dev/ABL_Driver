import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_images.dart';
import '../../../widget/navigator_method.dart';
import '../../../widget/primary_button.dart';
import '../../auth/login/ui/loginScreen.dart';
import '../../auth/registerScreen/ui/registerScreen.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.17,
          ),
          Image.asset(AppImages.onbording,
            height: screenHeight * 0.37,
            width: screenWidth,
          ),
          SizedBox(
            height: screenHeight * 0.08875,
          ),
          Padding(
              padding: EdgeInsets.all(15),
            child: Column(
              children: [
                const CustomText(
                  'Your Next Delivery Awaits',
                  size: 23,
                  color: ColorResource.black,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: screenHeight * 0.07875,
                ),
                PrimaryButton(
                  title: 'Login',
                  onTap: () {
                    print('Login clicked');
                    navPush(context: context, action: LoginScreen());
                  },
                ),
                SizedBox(height: 15,),
                RegisterButton(
                  title: 'Register',
                  onTap: () {
                    print('Register clicked');
                    navPush(context: context, action: RegisterScreen());
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
