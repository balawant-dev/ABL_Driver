class CmsModel {
  bool? status;
  String? message;
  CmsData? cmsData;

  CmsModel({this.status, this.message, this.cmsData});

  CmsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    cmsData =
    json['cmsData'] != null ? new CmsData.fromJson(json['cmsData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.cmsData != null) {
      data['cmsData'] = this.cmsData!.toJson();
    }
    return data;
  }
}

class CmsData {
  String? sId;
  String? type;
  String? aboutUs;
  String? agreement;
  String? privacyPolicy;
  String? refundPolicy;
  String? termAndConditions;

  CmsData(
      {this.sId,
        this.type,
        this.aboutUs,
        this.agreement,
        this.privacyPolicy,
        this.refundPolicy,
        this.termAndConditions});

  CmsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    aboutUs = json['aboutUs'];
    agreement = json['agreement'];
    privacyPolicy = json['privacyPolicy'];
    refundPolicy = json['refundPolicy'];
    termAndConditions = json['termAndConditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['aboutUs'] = this.aboutUs;
    data['agreement'] = this.agreement;
    data['privacyPolicy'] = this.privacyPolicy;
    data['refundPolicy'] = this.refundPolicy;
    data['termAndConditions'] = this.termAndConditions;
    return data;
  }
}
