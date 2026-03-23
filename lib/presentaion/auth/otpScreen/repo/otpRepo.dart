import '../../../../WebServices/app_url.dart';
import '../../../../WebServices/network/network_api_services.dart';
import '../model/verificationModel.dart';

class VerifyOtpRepository {
  final _apiService = NetworkApiServices();
  Future<VerificitionModel?> verifyOtpApi(var data) async {
    try {
      dynamic response =
      await _apiService.postApi(data, AppUrl.verifyOtp);
      return VerificitionModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}