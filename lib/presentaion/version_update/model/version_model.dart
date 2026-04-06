class AppVersionModel {
  final bool? success;
  final bool? updateAvailable;
  final bool? forceUpdate;
  final String? message;
  final String? playStoreUrl;

  AppVersionModel({
    this.success,
    this.updateAvailable,
    this.forceUpdate,
    this.message,
    this.playStoreUrl,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) {
    return AppVersionModel(
      success: json['success'] ?? false,
      updateAvailable: json['updateAvailable'] ?? false,
      forceUpdate: json['forceUpdate'] ?? true,
      message: json['message'] ?? "A new update is available.",
      playStoreUrl: json['playStoreUrl'] ??
          "https://play.google.com/store/apps/details?id=com.hrms.nexwage",
    );
  }
}