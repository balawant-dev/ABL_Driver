import 'package:abldriver/app/theme/color_resource.dart';
import 'package:abldriver/widget/custom_text.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off_rounded,
                size: 90,
                color: Color(0xFF086B48),
              ),
              const SizedBox(height: 20),
              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please check your internet connection and try again.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF086B48),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: onRetry,
                child: const CustomText(
                  'Retry',
                  size: 12,
                  color: ColorResource.white,
                  weight: FontWeight.w600,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
