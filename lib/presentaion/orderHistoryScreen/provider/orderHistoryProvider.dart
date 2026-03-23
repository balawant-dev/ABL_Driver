import 'package:flutter/cupertino.dart';

import '../model/oderHistoryModel.dart';
import '../model/orderHistoryByIdModel.dart';
import '../repo/orderHistoryRepo.dart';

class OrderHistoryProvider  with ChangeNotifier{
  final OrderHistoryRepository _repo = OrderHistoryRepository();
  bool loading = false;

  OderHistoryModel? getOrderHistoryData;

  Future<void> fetchOrderHistoryData() async {
    loading = true;
    notifyListeners();
    try {
      getOrderHistoryData = await _repo.getOrderHistoryApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }


  OrderHistoryByIdModel? orderHistoryByIdModel;
  bool orderHistoryLoading = false;

  Future<void> fetchOrderHistoryById(String orderId) async {
    try {
      orderHistoryLoading = true;
      notifyListeners();

      orderHistoryByIdModel =
      await _repo.getOrderHistoryByIdApi(orderId);

    } catch (e) {
      print("Error: $e");
    } finally {
      orderHistoryLoading = false;
      notifyListeners();
    }
  }


}