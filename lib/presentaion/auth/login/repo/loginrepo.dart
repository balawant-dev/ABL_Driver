
import '../../../../WebServices/app_url.dart';
import '../../../../WebServices/network/network_api_services.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> sendOtp(String mobileNumber) async {
    try {
      Map<String, dynamic> body = {
        "mobileNo": mobileNumber,
      };

      print("Send OTP API URL: ${AppUrl.sendOtp}");

      print("Send OTP Request Body: $body");

      dynamic response = await _apiService.postApi(body, AppUrl.sendOtp);

      print("Send OTP Response: $response");

      return response;
    } catch (e) {

      print("Send OTP Error: $e");
      rethrow;
    }
  }
}