

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'internetService.dart';
import 'no_Internet_Screen.dart';


class InternetWrapper extends StatefulWidget {
  final Widget child;

  const InternetWrapper({super.key, required this.child});

  @override
  State<InternetWrapper> createState() => _InternetWrapperState();
}

class _InternetWrapperState extends State<InternetWrapper> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();
    _checkInternet();

    _subscription =
        Connectivity().onConnectivityChanged.listen((_) {
          _checkInternet();
        });
  }

  Future<void> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      final hasInternet =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (mounted) {
        context.read<InternetService>().setInternetStatus(hasInternet);
      }
    } on SocketException {
      if (mounted) {
        context.read<InternetService>().setInternetStatus(false);
      }
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasInternet = context.watch<InternetService>().hasInternet;

    if (!hasInternet) {
      return NoInternetScreen(
        onRetry: _checkInternet,
      );
    }

    return widget.child;
  }
}


