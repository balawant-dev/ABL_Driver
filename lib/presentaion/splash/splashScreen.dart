
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_images.dart';
import '../auth/login/ui/loginScreen.dart';
import '../mainBottomBar/ui/mainBottomBar.dart';
import '../onboardingScreen/ui/onboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  // Future<void> _navigateAfterDelay() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //
  //   navPush(context: context, action: OnboardingScreen());
  // }
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    print("Device Token: $token");


    if (token != null && token.isNotEmpty) {
      // ✅ User already logged in
      navPush(context: context, action: MainBottomBar());
    } else {
      // ❌ New user
      navPush(context: context, action: OnboardingScreen());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashImage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            height: 123,
            width: 178  ,
            fit: BoxFit.contain,
          ),
        ),

      ),
    );
  }
}
