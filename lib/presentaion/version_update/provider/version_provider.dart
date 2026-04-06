import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../model/version_model.dart';
import '../repo/version_repo.dart';

class AppVersionProvider with ChangeNotifier {
  final VersionRepository _repo = VersionRepository();

  bool loading = false;
  AppVersionModel? appVersionModel;

  /// versionName -> 1.0.0
  Future<String> getCurrentVersionName() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  /// buildNumber -> Android versionCode
  Future<String> getCurrentBuildNumber() async {
    final info = await PackageInfo.fromPlatform();
    return info.buildNumber;
  }

  Future<void> fetchAppVersion() async {
    loading = true;
    notifyListeners();

    try {
      String currentBuildNumber = await getCurrentBuildNumber();
      String currentVersionName = await getCurrentVersionName();

      debugPrint("Current Installed VersionName: $currentVersionName");
      debugPrint("Current Installed BuildNumber: $currentBuildNumber");

      appVersionModel = await _repo.getAppVersionApi(currentBuildNumber);
    } catch (e) {
      debugPrint("App Version API ERROR: $e");
    }

    loading = false;
    notifyListeners();
  }
}