import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

class SocketService {
  static late IO.Socket socket;

  static Future<void> connectSocket() async {
    print("websocket connecting...");

    // 1️⃣ Get driverID from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? driverId = prefs.getString("driverID");

    if (driverId == null) {
      print("❌ driverID not found in SharedPreferences");
      return;
    }

    socket = IO.io(
      'http://192.168.1.11:5009',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      print('✅ Socket Connected');

      // 2️⃣ Emit join event with driverID
      socket.emit('join', {
        'driverId': driverId,
      });

      print('🚗 Join event sent with driverId: $driverId');
    });

    socket.onDisconnect((_) {
      print('❌ Socket Disconnected');
    });

    // 3️⃣ Listen booking event
    socket.on('bookingAssigned', (data) {
      print('📦 bookingAssigned event: $data');

      AwesomeNotificationService.showBookingNotification(
        title: 'New Booking Assigned 🚖',
        body: 'Booking ID: ${data['bookingId'] ?? 'New booking'}',
      );
    });
  }

  static void disconnect() {
    socket.disconnect();
  }
}
