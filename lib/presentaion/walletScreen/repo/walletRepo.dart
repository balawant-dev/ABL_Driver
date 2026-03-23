import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/walletGetModel.dart';
import '../model/walletPostModel.dart';


class WalletRepository {
  final _apiService = NetworkApiServices();

  Future<WalletGetModel> getWalletGetApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.Wallet);
      print('response: $response');
      if (response != null) {
        return WalletGetModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }



  Future<WalletPostModel> PostWallet({
    required double amount_requested,

  }) async {
    try {
      final Map<String, dynamic> body = {
        "amount_requested": amount_requested,

      };

      // Make the POST request
      final response = await _apiService.postApiWithToken(
          body,
          "${AppUrl.postWallet}"
      );

      print('response: $response');

      if (response != null) {
        return WalletPostModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error sending data: $e');
      rethrow;
    }
  }



}