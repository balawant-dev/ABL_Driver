// import 'dart:async';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// class FirebaseNotificationService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   bool _isInitialized = false;
//   late BuildContext context;
//
//   Future<void> init() async {
//     if (_isInitialized) return;
//     _isInitialized = true;
//     try {
//       NotificationSettings settings = await _firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//       );
//       if (settings.authorizationStatus != AuthorizationStatus.authorized) {
//         print(' Notification permission not granted');
//         return;
//       }
//       String? token = await _firebaseMessaging.getToken();
//       if (token != null) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString("deviceToken", token);
//         print(" FCM Token: $token");
//       }
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print(" Foreground Notification Received: ${message.notification?.title}");
//         if (message.notification != null) {
//           AwesomeNotifications().createNotification(
//             content: NotificationContent(
//               id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
//               channelKey: 'basic_channel',
//               title: message.notification?.title,
//               body: message.notification?.body,
//               notificationLayout: NotificationLayout.BigPicture,
//               bigPicture: message.notification?.android?.imageUrl ?? message.data['image'],
//               payload: {'screen': 'home'},
//             ),
//           );
//         }
//       });
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//         print(" App opened via notification");
//       });
//       AwesomeNotifications().setListeners(
//         onActionReceivedMethod: (ReceivedAction action) async {
//           await handleNotificationAction(action, context);
//         },
//       );
//     } catch (e) {
//       print(" Firebase Notification Init Error: $e");
//     }
//   }
//   Future<void> handleNotificationAction(ReceivedAction action, BuildContext context) async {
//     if (action.payload?['screen'] == 'home') {
//
//     }
//   }
// }



import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseService {

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// initialize all services
  static Future<void> init() async {

    await _requestPermission();

    await _initializeAwesome();

    await _printDeviceId();

    await _getFcmToken();

    _listenForegroundNotification();
  }

  /// Notification Permission
  static Future<void> _requestPermission() async {
    await _messaging.requestPermission();
  }

  /// Awesome Notification initialize
  static Future<void> _initializeAwesome() async {

    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
          channelShowBadge: true,
        )
      ],
    );
  }

  /// Device ID
  static Future<void> _printDeviceId() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final prefs = await SharedPreferences.getInstance();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      String deviceId = androidInfo.id ?? '';
      await prefs.setString("deviceId", deviceId);

      print("DEVICE ID : $deviceId");
    }

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      String deviceId = iosInfo.identifierForVendor ?? '';

      await prefs.setString("deviceId", deviceId);

      print("DEVICE ID : ${iosInfo.identifierForVendor}");
    }
  }

  /// FCM Token
  static Future<void> _getFcmToken() async {
    String? token = await _messaging.getToken();

    if (token != null) {

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("deviceToken", token);

      print("FCM TOKEN : $token");
    }
  }

  /// Foreground notification
  static void _listenForegroundNotification() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print("Notification Title : ${message.notification?.title}");
      print("Notification Body : ${message.notification?.body}");

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
        ),
      );
    });
  }
}