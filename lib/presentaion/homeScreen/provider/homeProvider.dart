import 'dart:io';

import 'package:flutter/material.dart';
import '../model/homeActiveStatusModel.dart';
import '../model/homeHederModel.dart';
import '../model/newOrderModel.dart';
import '../model/orderCompleteModel.dart';
import '../repo/homeRepo.dart';
import '../ui/onGoingOrderById.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepository _repo = HomeRepository();
  bool loading = false;
  HomeHederModel? getHomeHederData;

  Future<void> fetchHomeHederData() async {
    loading = true;
    notifyListeners();
    try {
      getHomeHederData = await _repo.getHomeHederApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }

  NewOrderModel? getNewOrderData;

  Future<void> fetchNewOrderData() async {
    loading = true;
    notifyListeners();
    try {
      getNewOrderData = await _repo.getNewOrderApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }


  Future<void> fetchOnGoingOrderData() async {
    loading = true;
    notifyListeners();
    try {
      getNewOrderData = await _repo.OnGoingOrderApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }


  bool isLoading = false;
  HomeActiveStatusModel? activeStatusModel;
  OrderCompleteModel? orderCompleteModel;

  Future<void> changeDriverStatus({
    required String driverId,
    required String status, // "active" / "inactive"
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      activeStatusModel = await _repo.getActiveStatusApi(
        driverId: driverId,
        status: status,
      );

      print("Status Updated Successfully");

    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  Future<void> acceptOrderStatus({
    required String orderId,
    required String status,  // "active" / "inactive"
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      activeStatusModel = await _repo.getAcceptOrderStatusApi(
        orderId: orderId,
        status: status,
      );
      fetchOnGoingOrderData();
      print("Status Updated Successfully");
      await fetchNewOrderData();
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



  Future<bool> acceptOrderStatus1({
    required String orderId,
    required String status,
    required BuildContext context,
    required File deliveryProofImage,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _repo.getAcceptOrderStatusApi1(
        orderId: orderId,
        status: status,
        deliveryProofImage: deliveryProofImage,
      );

      orderCompleteModel = response;

      if (response.status == true) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => DeliveryCompletedScreen(
              sId: orderId,
            ),
          ),
              (route) => false,
        );

        return true;   // ✅ success UI ko batao
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Order status update failed"),
          ),
        );
        return false;  // ❌ API error
      }


    } catch (e) {
      debugPrint("acceptOrderStatus Error: $e");
      return false;    // ❌ exception
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}