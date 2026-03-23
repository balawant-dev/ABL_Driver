import 'package:flutter/material.dart';
import '../repo/accountRepo.dart';
import '../model/accountDetailsModel.dart';

class AccountProvider extends ChangeNotifier {
  final AccountRepository _repository = AccountRepository();

  /// Controllers
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController benificiaryNameController = TextEditingController();
  final TextEditingController accountNoController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController reAccountNoController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AccountDetailsModel? accountDetails;
  String? validateAccountNumbers() {
    if (accountNoController.text.trim().isEmpty ||
        reAccountNoController.text.trim().isEmpty) {
      return "Please enter account number in both fields";
    }

    if (accountNoController.text.trim() !=
        reAccountNoController.text.trim()) {
      return "Account numbers do not match";
    }

    return null;
  }


  /// Update Account API
  // Future<void> updateAccount(BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   try {
  //     final response = await _repository.updateAccountData(
  //       bankName: bankNameController.text.trim(),
  //       branchName: branchNameController.text.trim(),
  //       benificiaryName: benificiaryNameController.text.trim(),
  //       accountNo: accountNoController.text.trim(),
  //       ifsc: ifscController.text.trim(),
  //     );
  //
  //     accountDetails = response;
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Account updated successfully")),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.toString())),
  //     );
  //   }
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }
  Future<void> updateAccount(BuildContext context) async {

    // ✅ CALL VALIDATION HERE
    final error = validateAccountNumbers();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return; // ❌ STOP API CALL
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _repository.updateAccountData(
        bankName: bankNameController.text.trim(),
        branchName: branchNameController.text.trim(),
        benificiaryName: benificiaryNameController.text.trim(),
        accountNo: accountNoController.text.trim(),
        ifsc: ifscController.text.trim(),
      );

      accountDetails = response;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }

    _isLoading = false;
    notifyListeners();
  }


  /// Dispose controllers
  @override
  void dispose() {
    bankNameController.dispose();
    branchNameController.dispose();
    benificiaryNameController.dispose();
    accountNoController.dispose();
    ifscController.dispose();
    super.dispose();
  }
}
