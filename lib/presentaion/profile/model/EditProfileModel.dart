class EditProfileModel {
  bool? success;
  String? message;
  Data? data;

  EditProfileModel({this.success, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? email;
  String? mobileNo;
  String? address;
  int? pincode;
  String? vehicleType;
  String? vehicleRcFrontImage;
  String? vehicleRcBackImage;
  String? idProofImage;
  String? profileImage;
  String? adharNumber;
  String? licenseNumber;

  Data(
      {this.name,
        this.email,
        this.mobileNo,
        this.address,
        this.pincode,
        this.vehicleType,
        this.vehicleRcFrontImage,
        this.vehicleRcBackImage,
        this.idProofImage,
        this.profileImage,
        this.adharNumber,
        this.licenseNumber});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    pincode = json['pincode'];
    vehicleType = json['vehicleType'];
    vehicleRcFrontImage = json['vehicleRcFrontImage'];
    vehicleRcBackImage = json['vehicleRcBackImage'];
    idProofImage = json['idProofImage'];
    profileImage = json['profileImage'];
    adharNumber = json['adharNumber'];
    licenseNumber = json['licenseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobileNo'] = this.mobileNo;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['vehicleType'] = this.vehicleType;
    data['vehicleRcFrontImage'] = this.vehicleRcFrontImage;
    data['vehicleRcBackImage'] = this.vehicleRcBackImage;
    data['idProofImage'] = this.idProofImage;
    data['profileImage'] = this.profileImage;
    data['adharNumber'] = this.adharNumber;
    data['licenseNumber'] = this.licenseNumber;
    return data;
  }
}
