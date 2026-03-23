class NotiFicationGetModel {
  String? status;
  Data? data;

  NotiFicationGetModel({this.status, this.data});

  NotiFicationGetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Notifications>? notifications;
  int? unreadCount;
  Pagination? pagination;

  Data({this.notifications, this.unreadCount, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    unreadCount = json['unreadCount'];
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    data['unreadCount'] = this.unreadCount;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? sId;
  String? recipient;
  String? recipientType;
  String? title;
  String? body;
  String? image;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notifications(
      {this.sId,
        this.recipient,
        this.recipientType,
        this.title,
        this.body,
        this.image,
        this.isRead,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    recipient = json['recipient'];
    recipientType = json['recipientType'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['recipient'] = this.recipient;
    data['recipientType'] = this.recipientType;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.total, this.page, this.limit, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
