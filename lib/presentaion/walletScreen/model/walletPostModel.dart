class WalletPostModel {
  String? message;
  String? status;
  Data? data;

  WalletPostModel({this.message, this.status, this.data});

  WalletPostModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? vendorId;
  String? driverId;
  int? amountRequested;
  String? message;
  String? status;
  bool? adminSettled;
  String? sId;
  String? requestDate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.vendorId,
        this.driverId,
        this.amountRequested,
        this.message,
        this.status,
        this.adminSettled,
        this.sId,
        this.requestDate,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    driverId = json['driverId'];
    amountRequested = json['amount_requested'];
    message = json['message'];
    status = json['status'];
    adminSettled = json['admin_settled'];
    sId = json['_id'];
    requestDate = json['request_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['driverId'] = this.driverId;
    data['amount_requested'] = this.amountRequested;
    data['message'] = this.message;
    data['status'] = this.status;
    data['admin_settled'] = this.adminSettled;
    data['_id'] = this.sId;
    data['request_date'] = this.requestDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
