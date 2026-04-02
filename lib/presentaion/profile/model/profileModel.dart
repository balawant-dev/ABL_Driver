class ProfileModel {
  bool? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? email;
  String? mobileNo;
  String? address;
  String? licenseNumber;
  String? adharNumber;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleModel;
  String? registrationNumber;
  String? insuranceNumber;
  String? deviceId;
  String? deviceToken;
  String? ifsc;
  String? bankName;
  String? branchName;
  String? accountNo;
  String? benificiaryName;
  String? personWithDisability;
  int? pincode;
  String? profileImage;
  String? vehicleRcFrontImage;
  String? vehicleRcBackImage;
  String? idProofImage;
  String? status;

  Data(
      {this.sId,
        this.name,
        this.email,
        this.mobileNo,
        this.address,
        this.licenseNumber,
        this.adharNumber,
        this.vehicleType,
        this.vehicleNumber,
        this.vehicleModel,
        this.registrationNumber,
        this.insuranceNumber,
        this.deviceId,
        this.deviceToken,
        this.ifsc,
        this.bankName,
        this.branchName,
        this.accountNo,
        this.benificiaryName,
        this.personWithDisability,
        this.pincode,
        this.profileImage,
        this.vehicleRcFrontImage,
        this.vehicleRcBackImage,
        this.idProofImage,
        this.status
      });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    mobileNo = json['vehicleNumber'];
    address = json['address'];
    licenseNumber = json['licenseNumber'];
    adharNumber = json['adharNumber'];
    vehicleType = json['vehicleType'];
    vehicleModel = json['vehicleModel'];
    registrationNumber = json['registrationNumber'];
    insuranceNumber = json['insuranceNumber'];
    deviceId = json['deviceId'];
    deviceToken = json['deviceToken'];
    ifsc = json['ifsc'];
    bankName = json['bankName'];
    branchName = json['branchName'];
    accountNo = json['accountNo'];
    benificiaryName = json['benificiaryName'];
    personWithDisability = json['personWithDisability'];
    pincode = json['pincode'];
    profileImage = json['profileImage'];
    vehicleRcFrontImage = json['vehicleRcFrontImage'];
    vehicleRcBackImage = json['vehicleRcBackImage'];
    idProofImage = json['idProofImage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['vehicleNumber'] = this.vehicleNumber;
    data['licenseNumber'] = this.licenseNumber;
    data['adharNumber'] = this.adharNumber;
    data['vehicleType'] = this.vehicleType;
    data['vehicleModel'] = this.vehicleModel;
    data['registrationNumber'] = this.registrationNumber;
    data['insuranceNumber'] = this.insuranceNumber;
    data['deviceId'] = this.deviceId;
    data['deviceToken'] = this.deviceToken;
    data['ifsc'] = this.ifsc;
    data['bankName'] = this.bankName;
    data['branchName'] = this.branchName;
    data['accountNo'] = this.accountNo;
    data['benificiaryName'] = this.benificiaryName;
    data['personWithDisability'] = this.personWithDisability;
    data['pincode'] = this.pincode;
    data['profileImage'] = this.profileImage;
    data['vehicleRcFrontImage'] = this.vehicleRcFrontImage;
    data['vehicleRcBackImage'] = this.vehicleRcBackImage;
    data['idProofImage'] = this.idProofImage;
    data['status'] = this.status;
    return data;
  }
}
