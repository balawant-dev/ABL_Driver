import 'package:flutter/material.dart';

class InternetService extends ChangeNotifier {
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  void setInternetStatus(bool status) {
    if (_hasInternet != status) {
      _hasInternet = status;
      notifyListeners();
    }
  }
}
