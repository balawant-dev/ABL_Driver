import 'dart:io';
import 'package:abldriver/widget/navigator_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_images.dart';
import '../mainBottomBar/ui/mainBottomBar.dart';
import '../onboardingScreen/ui/onboardingScreen.dart';
import '../version_update/provider/version_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    final appProvider = Provider.of<AppVersionProvider>(
      context,
      listen: false,
    );
    await appProvider.fetchAppVersion();
    if (!mounted) return;
    await checkVersionAndShowDialog(appProvider);
    if (!_dialogShown) {
      await _navigateAfterDelay();
    }
  }

  void showUpdateDialog({
    required String message,
    required bool forceUpdate,
    required String playStoreUrl,
  }) {
    if (_dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.system_update,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    forceUpdate ? "Update Required" : "Update Available",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final url = Uri.parse(playStoreUrl);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "Update Now",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  if (!forceUpdate) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _dialogShown = false;
                          await _navigateAfterDelay();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Later"),
                      ),
                    ),
                  ],

                  if (forceUpdate) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else {
                            exit(0);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Exit App"),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> checkVersionAndShowDialog(AppVersionProvider appProvider) async {
    try {
      final versionData = appProvider.appVersionModel;
      if (versionData == null) return;
      debugPrint("API success: ${versionData.success}");
      debugPrint("API updateAvailable: ${versionData.updateAvailable}");
      debugPrint("API forceUpdate: ${versionData.forceUpdate}");
      if (versionData.success == true && versionData.updateAvailable == true) {
        showUpdateDialog(
          message: versionData.message ?? "A new update is available.",
          forceUpdate: versionData.forceUpdate ?? true,
          playStoreUrl: versionData.playStoreUrl ??
              "https://play.google.com/store/apps/details?id=com.hrms.nexwage",
        );
      }
    } catch (e) {
      debugPrint("Version error: $e");
    }
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    debugPrint("Auth Token: $token");
    if (!mounted) return;
    if (token != null && token.isNotEmpty) {
      navPush(context: context, action: const MainBottomBar());
    } else {
      navPush(context: context, action: const OnboardingScreen());
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
            image: AssetImage("assets/images/Splashimage2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.logo,
            height: 123,
            width: 178,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}