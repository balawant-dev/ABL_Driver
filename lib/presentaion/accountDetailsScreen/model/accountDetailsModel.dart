class AccountDetailsModel {
  bool? success;
  String? message;
  Data? data;

  AccountDetailsModel({this.success, this.message, this.data});

  AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
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

  Data(
      {this.sId,
        this.name,
        this.email,
        this.mobileNo,
        this.address,
        this.licenseNumber,
        this.adharNumber,
        this.vehicleType,
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
        this.idProofImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    licenseNumber = json['licenseNumber'];
    adharNumber = json['adharNumber'];
    vehicleType = json['vehicleType'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['licenseNumber'] = this.licenseNumber;
    data['adharNumber'] = this.adharNumber;
    data['vehicleType'] = this.vehicleType;
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
    return data;
  }
}
