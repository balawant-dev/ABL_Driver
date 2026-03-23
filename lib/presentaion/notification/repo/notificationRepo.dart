import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/notificationGetModel.dart';
import '../model/notificationReadModel.dart';



class NotificationRepository {
  final _apiService = NetworkApiServices();

  Future<NotiFicationGetModel> getNotificationApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.notification);
      print('response: $response');
      if (response != null) {
        return NotiFicationGetModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }
  Future<ReadNotificationModel> updateNotificationApi() async {
    try {
      final response = await _apiService.patchApiWithToken(
        AppUrl.notificationRead,
        {},
      );

      print('response: $response');

      if (response != null) {
        return ReadNotificationModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }
}