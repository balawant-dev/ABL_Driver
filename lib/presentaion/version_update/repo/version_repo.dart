import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/version_model.dart';

class VersionRepository {
  final _apiService = NetworkApiServices();

  Future<AppVersionModel> getAppVersionApi(String currentVersion) async {
    try {
      final body = {
        "currentVersion": currentVersion,
      };

      final response = await _apiService.postApi(
        body,
        AppUrl.appVersion,
      );

      print("Request Body: $body");
      print("Response: $response");

      if (response != null) {
        return AppVersionModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching version data: $e');
      rethrow;
    }
  }
}