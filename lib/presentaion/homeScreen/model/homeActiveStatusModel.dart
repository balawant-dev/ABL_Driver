class HomeActiveStatusModel {
  bool? success;
  String? message;
  Driver? driver;

  HomeActiveStatusModel({this.success, this.message, this.driver});

  HomeActiveStatusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    driver =
    json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    return data;
  }
}

class Driver {
  Otp? otp;
  Vehicle? vehicle;
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? mobileNo;
  String? password;
  String? address;
  String? image;
  String? serviceType;
  String? status;
  String? licenseNumber;
  String? adharNumber;
  String? vehicleRcImage;
  String? insuranceImage;
  String? licenseImage;
  String? adharImage;
  int? commission;
  int? walletBalance;
  int? cashCollection;
  String? payoutType;
  String? personWithDisability;
  String? ifsc;
  String? bankName;
  String? branchName;
  String? accountNo;
  String? benificiaryName;
  String? passbook;
  bool? isVerified;
  bool? isBlocked;
  String? deviceId;
  String? deviceToken;
  String? currentOrderId;
  String? rating;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? pincode;
  String? idProofImage;
  String? profileImage;
  String? vehicleRcBackImage;
  String? vehicleRcFrontImage;

  Driver(
      {this.otp,
        this.vehicle,
        this.location,
        this.sId,
        this.name,
        this.email,
        this.mobileNo,
        this.password,
        this.address,
        this.image,
        this.serviceType,
        this.status,
        this.licenseNumber,
        this.adharNumber,
        this.vehicleRcImage,
        this.insuranceImage,
        this.licenseImage,
        this.adharImage,
        this.commission,
        this.walletBalance,
        this.cashCollection,
        this.payoutType,
        this.personWithDisability,
        this.ifsc,
        this.bankName,
        this.branchName,
        this.accountNo,
        this.benificiaryName,
        this.passbook,
        this.isVerified,
        this.isBlocked,
        this.deviceId,
        this.deviceToken,
        this.currentOrderId,
        this.rating,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.pincode,
        this.idProofImage,
        this.profileImage,
        this.vehicleRcBackImage,
        this.vehicleRcFrontImage});

  Driver.fromJson(Map<String, dynamic> json) {
    otp = json['otp'] != null ? new Otp.fromJson(json['otp']) : null;
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    password = json['password'];
    address = json['address'];
    image = json['image'];
    serviceType = json['serviceType'];
    status = json['status'];
    licenseNumber = json['licenseNumber'];
    adharNumber = json['adharNumber'];
    vehicleRcImage = json['vehicleRcImage'];
    insuranceImage = json['insuranceImage'];
    licenseImage = json['licenseImage'];
    adharImage = json['adharImage'];
    commission = json['commission'];
    walletBalance = json['wallet_balance'];
    cashCollection = json['cashCollection'];
    payoutType = json['payoutType'];
    personWithDisability = json['personWithDisability'];
    ifsc = json['ifsc'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    accountNo = json['accountNo'];
    benificiaryName = json['benificiaryName'];
    passbook = json['passbook'];
    isVerified = json['isVerified'];
    isBlocked = json['isBlocked'];
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    currentOrderId = json['currentOrderId'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    pincode = json['pincode'];
    idProofImage = json['idProofImage'];
    profileImage = json['profileImage'];
    vehicleRcBackImage = json['vehicleRcBackImage'];
    vehicleRcFrontImage = json['vehicleRcFrontImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.otp != null) {
      data['otp'] = this.otp!.toJson();
    }
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['password'] = this.password;
    data['address'] = this.address;
    data['image'] = this.image;
    data['serviceType'] = this.serviceType;
    data['status'] = this.status;
    data['licenseNumber'] = this.licenseNumber;
    data['adharNumber'] = this.adharNumber;
    data['vehicleRcImage'] = this.vehicleRcImage;
    data['insuranceImage'] = this.insuranceImage;
    data['licenseImage'] = this.licenseImage;
    data['adharImage'] = this.adharImage;
    data['commission'] = this.commission;
    data['wallet_balance'] = this.walletBalance;
    data['cashCollection'] = this.cashCollection;
    data['payoutType'] = this.payoutType;
    data['personWithDisability'] = this.personWithDisability;
    data['ifsc'] = this.ifsc;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['accountNo'] = this.accountNo;
    data['benificiaryName'] = this.benificiaryName;
    data['passbook'] = this.passbook;
    data['isVerified'] = this.isVerified;
    data['isBlocked'] = this.isBlocked;
    data['deviceId'] = this.deviceId;
    data['deviceToken'] = this.deviceToken;
    data['currentOrderId'] = this.currentOrderId;
    data['rating'] = this.rating;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['pincode'] = this.pincode;
    data['idProofImage'] = this.idProofImage;
    data['profileImage'] = this.profileImage;
    data['vehicleRcBackImage'] = this.vehicleRcBackImage;
    data['vehicleRcFrontImage'] = this.vehicleRcFrontImage;
    return data;
  }
}

class Otp {
  String? code;
  String? expiresAt;

  Otp({this.code, this.expiresAt});

  Otp.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    expiresAt = json['expiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['expiresAt'] = this.expiresAt;
    return data;
  }
}

class Vehicle {
  String? type;
  String? model;
  String? registrationNumber;
  String? insuranceNumber;

  Vehicle(
      {this.type, this.model, this.registrationNumber, this.insuranceNumber});

  Vehicle.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    model = json['model'];
    registrationNumber = json['registrationNumber'];
    insuranceNumber = json['insuranceNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['model'] = this.model;
    data['registrationNumber'] = this.registrationNumber;
    data['insuranceNumber'] = this.insuranceNumber;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
