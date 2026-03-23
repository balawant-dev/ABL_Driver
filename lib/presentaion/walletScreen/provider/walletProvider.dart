import '../model/walletGetModel.dart';
import '../model/walletPostModel.dart';
import '../repo/walletRepo.dart';
import 'package:flutter/material.dart';

class WalletProvider with ChangeNotifier {
  final WalletRepository _repo = WalletRepository();
  bool loading = false;
  WalletGetModel? walletGetModel;

  Future<void> fetchwalletData() async {
    loading = true;
    notifyListeners();
    try {
      walletGetModel = await _repo.getWalletGetApi();
    } catch (e) {
      print("ReservedRides API ERROR: $e");
    }
    loading = false;
    notifyListeners();
  }
  bool _loading1 = false;

  WalletPostModel? _postWalletResponse;
  WalletPostModel? get postWalletResponse => _postWalletResponse;

  String? _error;
  String? get error => _error;

  Future<void> PostWallet({
    required double amount_requested,

  }) async {
    _loading1 = true;
    _error = null;
    notifyListeners();

    try {
      _postWalletResponse = await _repo.PostWallet(
        amount_requested: amount_requested,

      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading1 = false;
      notifyListeners();
    }
  }

}