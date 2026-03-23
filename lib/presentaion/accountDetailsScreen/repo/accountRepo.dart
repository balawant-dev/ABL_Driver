import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/accountDetailsModel.dart';




class AccountRepository {
  final _apiService = NetworkApiServices();

  Future<AccountDetailsModel> updateAccountData({
    required String bankName,
    required String branchName,
    required String benificiaryName,
    required String accountNo,
    required String ifsc,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "bankName": bankName,
        "branchName": branchName,
        "benificiaryName": benificiaryName,
        "accountNo": accountNo,
        "ifsc": ifsc,
      };


      final response = await _apiService.patchApiWithToken(
        AppUrl.profileUpdate,
        body,
      );

      print('response: $response');

      if (response != null) {
        return AccountDetailsModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }
}
