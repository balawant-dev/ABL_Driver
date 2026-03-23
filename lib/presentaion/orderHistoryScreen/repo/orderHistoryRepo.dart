import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/oderHistoryModel.dart';
import '../model/orderHistoryByIdModel.dart';


class OrderHistoryRepository {
  final _apiService = NetworkApiServices();
  Future<OderHistoryModel> getOrderHistoryApi() async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.newOrder}?type=all");
      print('response: $response');
      if (response != null) {
        return OderHistoryModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }


  Future<OrderHistoryByIdModel> getOrderHistoryByIdApi(String orderId) async {
    try {
      final response = await _apiService.getApiWithToken(
        "${AppUrl.orderHistoryDetails}/$orderId",
      );

      print('Order By Id response: $response');

      if (response != null) {
        return OrderHistoryByIdModel.fromJson(response);
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching order by id: $e');
      rethrow;
    }
  }


}