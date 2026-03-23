class VerificitionModel {
  bool? status;
  String? token;
  Data? data;

  VerificitionModel({this.status, this.token, this.data});

  VerificitionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? mobileNo;
  int? pincode;
  String? sId;
  String? deviceId;
  String? deviceToken;
  String? address;

  User(
      {this.name,
        this.email,
        this.mobileNo,
        this.pincode,
        this.sId,
        this.deviceId,
        this.deviceToken,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    pincode = json['pincode'];
    sId = json['_id'];
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['pincode'] = this.pincode;
    data['_id'] = this.sId;
    data['deviceId'] = this.deviceId;
    data['deviceToken'] = this.deviceToken;
    data['address'] = this.address;
    return data;
  }
}
