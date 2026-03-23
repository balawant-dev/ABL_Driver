class SosPostModel {
  bool? success;
  String? message;
  Query? query;

  SosPostModel({this.success, this.message, this.query});

  SosPostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    query = json['query'] != null ? new Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
    return data;
  }
}

class Query {
  String? name;
  String? number;
  String? remark;
  String? userType;
  String? userId;
  String? userModel;
  String? status;
  String? adminReply;
  String? repliedAt;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Query(
      {this.name,
        this.number,
        this.remark,
        this.userType,
        this.userId,
        this.userModel,
        this.status,
        this.adminReply,
        this.repliedAt,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Query.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    remark = json['remark'];
    userType = json['userType'];
    userId = json['userId'];
    userModel = json['userModel'];
    status = json['status'];
    adminReply = json['adminReply'];
    repliedAt = json['repliedAt'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['number'] = this.number;
    data['remark'] = this.remark;
    data['userType'] = this.userType;
    data['userId'] = this.userId;
    data['userModel'] = this.userModel;
    data['status'] = this.status;
    data['adminReply'] = this.adminReply;
    data['repliedAt'] = this.repliedAt;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
