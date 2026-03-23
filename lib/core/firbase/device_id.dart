import 'dart:io';
import 'package:abldriver/widget/custom_App_bar.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceIdScreen extends StatefulWidget {
  @override
  State<DeviceIdScreen> createState() => _DeviceIdScreenState();
}

class _DeviceIdScreenState extends State<DeviceIdScreen> {
  String deviceId = "Unknown";

  @override
  void initState() {
    super.initState();
    getDeviceId();
  }

  getDeviceId() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceId = androidInfo.id ?? 'Unavailable';
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceId = iosInfo.identifierForVendor ?? 'Unavailable';
        });
      } else {
        setState(() {
          deviceId = 'Unsupported platform';
        });
      }
    } catch (e) {
      setState(() {
        deviceId = 'Failed to get device ID: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Device Id',),
      body: Center(
        child: Text('Device ID: $deviceId'),
      ),
    );
  }
}
