class WalletGetModel {
  String? message;
  String? status;
  int? walletBalance;
  int? cashCollection;
  List<TransactionHistory>? transactionHistory;
  List<SettlementHistory>? settlementHistory;

  WalletGetModel(
      {this.message,
        this.status,
        this.walletBalance,
        this.cashCollection,
        this.transactionHistory,
        this.settlementHistory});

  WalletGetModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    walletBalance = json['walletBalance'];
    cashCollection = json['cashCollection'];
    if (json['transactionHistory'] != null) {
      transactionHistory = <TransactionHistory>[];
      json['transactionHistory'].forEach((v) {
        transactionHistory!.add(new TransactionHistory.fromJson(v));
      });
    }
    if (json['settlementHistory'] != null) {
      settlementHistory = <SettlementHistory>[];
      json['settlementHistory'].forEach((v) {
        settlementHistory!.add(new SettlementHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['walletBalance'] = this.walletBalance;
    data['cashCollection'] = this.cashCollection;
    if (this.transactionHistory != null) {
      data['transactionHistory'] =
          this.transactionHistory!.map((v) => v.toJson()).toList();
    }
    if (this.settlementHistory != null) {
      data['settlementHistory'] =
          this.settlementHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionHistory {
  String? sId;
  String? driverId;
  String? action;
  int? amount;
  int? balanceAfterAction;
  String? razorpayOrderId;
  String? orderId;
  String? paymentId;
  String? status;
  String? description;
  String? createdAt;
  int? iV;

  TransactionHistory(
      {this.sId,
        this.driverId,
        this.action,
        this.amount,
        this.balanceAfterAction,
        this.razorpayOrderId,
        this.orderId,
        this.paymentId,
        this.status,
        this.description,
        this.createdAt,
        this.iV});

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driverId = json['driverId'];
    action = json['action'];
    amount = json['amount'];
    balanceAfterAction = json['balance_after_action'];
    razorpayOrderId = json['razorpayOrderId'];
    orderId = json['orderId'];
    paymentId = json['paymentId'];
    status = json['status'];
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driverId'] = this.driverId;
    data['action'] = this.action;
    data['amount'] = this.amount;
    data['balance_after_action'] = this.balanceAfterAction;
    data['razorpayOrderId'] = this.razorpayOrderId;
    data['orderId'] = this.orderId;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class SettlementHistory {
  String? sId;
  String? vendorId;
  String? driverId;
  int? amountRequested;
  String? message;
  String? status;
  bool? adminSettled;
  String? requestDate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SettlementHistory(
      {this.sId,
        this.vendorId,
        this.driverId,
        this.amountRequested,
        this.message,
        this.status,
        this.adminSettled,
        this.requestDate,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SettlementHistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    vendorId = json['vendorId'];
    driverId = json['driverId'];
    amountRequested = json['amount_requested'];
    message = json['message'];
    status = json['status'];
    adminSettled = json['admin_settled'];
    requestDate = json['request_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['vendorId'] = this.vendorId;
    data['driverId'] = this.driverId;
    data['amount_requested'] = this.amountRequested;
    data['message'] = this.message;
    data['status'] = this.status;
    data['admin_settled'] = this.adminSettled;
    data['request_date'] = this.requestDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
