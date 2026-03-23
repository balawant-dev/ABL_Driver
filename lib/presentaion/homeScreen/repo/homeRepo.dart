import 'dart:io';

import 'package:dio/dio.dart';

import '../../../WebServices/app_url.dart';
import '../../../WebServices/network/network_api_services.dart';
import '../model/homeActiveStatusModel.dart';
import '../model/homeHederModel.dart';
import '../model/newOrderModel.dart';
import '../model/orderCompleteModel.dart';


class HomeRepository {
  final _apiService = NetworkApiServices();

  Future<HomeHederModel> getHomeHederApi() async {
    try {
      final response = await _apiService.getApiWithToken(AppUrl.homeHeder);
      print('response: $response');
      if (response != null) {
        return HomeHederModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }


  Future<NewOrderModel> getNewOrderApi() async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.newOrder}?type=new");
      print('response: $response');
      if (response != null) {
        return NewOrderModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<NewOrderModel> OnGoingOrderApi() async {
    try {
      final response = await _apiService.getApiWithToken("${AppUrl.newOrder}?type=ongoing");
      print('response: $response');
      if (response != null) {
        return NewOrderModel.fromJson(response);
      } else {
        throw Exception('Failed to load data: response is null');
      }
    } catch (e) {
      print('Error fetching  data: $e');
      rethrow;
    }
  }

  Future<HomeActiveStatusModel> getActiveStatusApi({
    required String driverId,
    required String status,
  }) async {
    final body = {
      "status": status,
    };

    final response = await _apiService.patchApiWithToken(
      "${AppUrl.activeStatus}/$driverId",
      body,
    );

    return HomeActiveStatusModel.fromJson(response);
  }

  Future<HomeActiveStatusModel> getAcceptOrderStatusApi({
    required String orderId,
    required String status,
  }) async {
    final body = {
      "status": status,
    };

    final response = await _apiService.patchApiWithToken(
      "${AppUrl.acceptStatus}/$orderId",
      body,
    );

    return HomeActiveStatusModel.fromJson(response);
  }


  Future<OrderCompleteModel> getAcceptOrderStatusApi1({
    required String orderId,
    required String status,
    required File deliveryProofImage,
  }) async {

    final response = await _apiService.patchMultipartApiWithToken1(
      url: "${AppUrl.acceptStatus}/$orderId",
      fields: {
        "status": status,
      },
      imageFile: deliveryProofImage,
      fileFieldName: "deliveryProofImage",
    );

    return OrderCompleteModel.fromJson(response);
  }



}
