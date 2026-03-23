import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotificationService {
  static Future<void> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'booking_channel',
          channelName: 'Booking Notifications',
          channelDescription: 'Notification for booking assignment',
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        ),
      ],
    );

    // Ask permission
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static Future<void> showBookingNotification({
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'booking_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
