
import 'package:abldriver/presentaion/notification/provider/notificationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:abldriver/presentaion/accountDetailsScreen/provider/accountProvider.dart';
import 'package:abldriver/presentaion/auth/login/provider/loginProvider.dart';
import 'package:abldriver/presentaion/auth/otpScreen/provider/otpProvider.dart';
import 'package:abldriver/presentaion/auth/registerScreen/provider/registerProvider.dart';
import 'package:abldriver/presentaion/cmsScreen/provider/cmsProvider.dart';
import 'package:abldriver/presentaion/homeScreen/provider/homeProvider.dart';
import 'package:abldriver/presentaion/orderHistoryScreen/provider/orderHistoryProvider.dart';
import 'package:abldriver/presentaion/profile/provider/profileProvider.dart';
import 'package:abldriver/presentaion/sosScreen/provider/sosProvider.dart';
import 'package:abldriver/presentaion/splash/splashScreen.dart';
import 'package:abldriver/presentaion/walletScreen/provider/walletProvider.dart';
import 'package:abldriver/internetService/InterNetWapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/firbase/firbase_service.dart';
import 'firebase_options.dart';
import 'internetService/internetService.dart';
import 'presentaion/splash/splashScreen.dart';

// your providers imports...

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initialize Firebase Service
  await FirebaseService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InternetService()),

        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => OrderHistoryProvider()),
        ChangeNotifierProvider(create: (_) => SosProvider()),
        ChangeNotifierProvider(create: (_) => CmsProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'ABL Driverss',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return InternetWrapper(child: child!);
        },

        home: const SplashScreen(),
      ),
    );
  }
}
