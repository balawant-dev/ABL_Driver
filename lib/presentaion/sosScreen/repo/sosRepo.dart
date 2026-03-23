import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/sosPostModel.dart';



class SosRepository {
  final _apiService = NetworkApiServices();

  /// Send SOS data
  Future<SosPostModel> sendSosData({
    required String name,
    required String number,
    required String remark,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "name": name,
        "number": number,
        "remark": remark,
      };

      // Make the POST request
      final response = await _apiService.postApiWithToken(
        body,
        "${AppUrl.sos}"
      );

      print('response: $response');

      if (response != null) {
        return SosPostModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }
}
