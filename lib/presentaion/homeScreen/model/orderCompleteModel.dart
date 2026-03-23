class OrderCompleteModel {
  var status;
  var message;
  Data? data;
  WalletTransaction? walletTransaction;
  var newWalletBalance;
  var driverWalletBalance;

  OrderCompleteModel(
      {this.status,
        this.message,
        this.data,
        this.walletTransaction,
        this.newWalletBalance,
        this.driverWalletBalance});

  OrderCompleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    walletTransaction = json['walletTransaction'] != null
        ? new WalletTransaction.fromJson(json['walletTransaction'])
        : null;
    newWalletBalance = json['newWalletBalance'];
    driverWalletBalance = json['driverWalletBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.walletTransaction != null) {
      data['walletTransaction'] = this.walletTransaction!.toJson();
    }
    data['newWalletBalance'] = this.newWalletBalance;
    data['driverWalletBalance'] = this.driverWalletBalance;
    return data;
  }
}

class Data {
  var itemTotal;
  var packingCharge;
  var driverDeliveryCharge;
  var vendorAmount;

  Data(
      {this.itemTotal,
        this.packingCharge,
        this.driverDeliveryCharge,
        this.vendorAmount});

  Data.fromJson(Map<String, dynamic> json) {
    itemTotal = json['itemTotal'];
    packingCharge = json['packingCharge'];
    driverDeliveryCharge = json['driverDeliveryCharge'];
    vendorAmount = json['vendorAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemTotal'] = this.itemTotal;
    data['packingCharge'] = this.packingCharge;
    data['driverDeliveryCharge'] = this.driverDeliveryCharge;
    data['vendorAmount'] = this.vendorAmount;
    return data;
  }
}

class WalletTransaction {
  var orderId;
  var vendorId;
  var amount;
  var commission;
  var commissionAmount;
  var gst;
  var gstAmount;
  var type;
  var isBonus;
  var finalAmount;
  var sId;
  var createdAt;
  var iV;

  WalletTransaction(
      {this.orderId,
        this.vendorId,
        this.amount,
        this.commission,
        this.commissionAmount,
        this.gst,
        this.gstAmount,
        this.type,
        this.isBonus,
        this.finalAmount,
        this.sId,
        this.createdAt,
        this.iV});

  WalletTransaction.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    vendorId = json['vendorId'];
    amount = json['amount'];
    commission = json['commission'];
    commissionAmount = json['commission_amount'];
    gst = json['gst'];
    gstAmount = json['gst_amount'];
    type = json['type'];
    isBonus = json['is_bonus'];
    finalAmount = json['final_amount'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['vendorId'] = this.vendorId;
    data['amount'] = this.amount;
    data['commission'] = this.commission;
    data['commission_amount'] = this.commissionAmount;
    data['gst'] = this.gst;
    data['gst_amount'] = this.gstAmount;
    data['type'] = this.type;
    data['is_bonus'] = this.isBonus;
    data['final_amount'] = this.finalAmount;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
