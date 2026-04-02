class NewOrderModel {
  bool? success;
  String? message;
  var count;
  List<OrderList>? orderList;

  NewOrderModel({this.success, this.message, this.count, this.orderList});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    if (json['orderList'] != null) {
      orderList = <OrderList>[];
      json['orderList'].forEach((v) {
        orderList!.add(new OrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.orderList != null) {
      data['orderList'] = this.orderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderList {
  String? sId;
  String? bookingId;
  Pickup? pickup;
  Delivery? delivery;
  List<Products>? products;
  String? status;
  var deliveryCharge;
  var totalAmount;
  String? paymentMode;
  String? createdAt;
  String? deliveredAt;
  String? pickedupAt;
  var totalKm;

  OrderList(
      {this.sId,
        this.bookingId,
        this.pickup,
        this.delivery,
        this.products,
        this.status,
        this.deliveryCharge,
        this.totalAmount,
        this.paymentMode,
        this.createdAt,
        this.pickedupAt,
        this.deliveredAt,
        this.totalKm});

  OrderList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bookingId = json['bookingId'];
    pickup =
    json['pickup'] != null ? new Pickup.fromJson(json['pickup']) : null;
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    status = json['status'];
    deliveryCharge = json['deliveryCharge'];
    totalAmount = json['totalAmount'];
    paymentMode = json['paymentMode'];
    createdAt = json['createdAt'];
    pickedupAt = json['pickedupAt'];
    deliveredAt = json['deliveredAt'];
    totalKm = json['totalKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bookingId'] = this.bookingId;
    if (this.pickup != null) {
      data['pickup'] = this.pickup!.toJson();
    }
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['deliveryCharge'] = this.deliveryCharge;
    data['totalAmount'] = this.totalAmount;
    data['paymentMode'] = this.paymentMode;
    data['createdAt'] = this.createdAt;
    data['pickedupAt'] = this.pickedupAt;
    data['deliveredAt'] = this.deliveredAt;
    data['totalKm'] = this.totalKm;
    return data;
  }
}

class Pickup {
  String? name;
  String? address;
  String? image;
  String? mobileNo;
  double? lat;
  double? long;

  Pickup(
      {this.name,
        this.address,
        this.image,
        this.mobileNo,
        this.lat,
        this.long});

  Pickup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    image = json['image'];
    mobileNo = json['mobileNo'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['image'] = this.image;
    data['mobileNo'] = this.mobileNo;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}

class Delivery {
  String? image;
  String? name;
  String? mobileNo;
  String? address1;
  String? address2;
  double? lat;
  double? long;
  String? city;
  var pincode;
  String? state;
  String? deliveryInsturction;

  Delivery(
      {this.image,
        this.name,
        this.mobileNo,
        this.address1,
        this.address2,
        this.lat,
        this.long,
        this.city,
        this.pincode,
        this.state,
        this.deliveryInsturction});

  Delivery.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    mobileNo = json['mobileNo'];
    address1 = json['address1'];
    address2 = json['address2'];
    lat = json['lat'];
    long = json['long'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    deliveryInsturction = json['deliveryInsturction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['mobileNo'] = this.mobileNo;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['deliveryInsturction'] = this.deliveryInsturction;
    return data;
  }
}

class Products {
  String? name;
  var price;
  var quantity;
  var finalPrice;

  Products({this.name, this.price, this.quantity, this.finalPrice});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    finalPrice = json['finalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['finalPrice'] = this.finalPrice;
    return data;
  }
}
