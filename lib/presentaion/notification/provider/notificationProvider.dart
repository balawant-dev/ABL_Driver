import 'package:flutter/material.dart';

import '../model/notificationGetModel.dart';
import '../model/notificationReadModel.dart';
import '../repo/notificationRepo.dart';



class NotificationProvider with ChangeNotifier {
  final NotificationRepository _repo = NotificationRepository();
  bool loading = false;
  NotiFicationGetModel? notiFicationGetModel;

  Future<void> fetchCmsData() async {
    loading = true;
    notifyListeners();
    try {
      notiFicationGetModel = await _repo.getNotificationApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }


  ReadNotificationModel? readNotificationModel;
  Future<void> updateNotification() async {
    loading = true;
    notifyListeners();

    try {
      readNotificationModel = await _repo.updateNotificationApi();
    } catch (e) {
      debugPrint("Notification Update Error: $e");
    }

    loading = false;
    notifyListeners();
  }
}