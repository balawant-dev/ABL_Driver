import 'package:flutter/material.dart';

import '../model/sosPostModel.dart';
import '../repo/sosRepo.dart';


class SosProvider with ChangeNotifier {
  final SosRepository _repository = SosRepository();

  bool _loading = false;
  bool get loading => _loading;

  SosPostModel? _sosResponse;
  SosPostModel? get sosResponse => _sosResponse;

  String? _error;
  String? get error => _error;

  Future<void> sendSos({
    required String name,
    required String number,
    required String remark,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _sosResponse = await _repository.sendSosData(
        name: name,
        number: number,
        remark: remark,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
