class OrderHistoryByIdModel {
  bool? success;
  var message;
  Order? order;

  OrderHistoryByIdModel({this.success, this.message, this.order});

  OrderHistoryByIdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  var sId;
  var bookingId;
  Pickup? pickup;
  Delivery? delivery;
  List<Products>? products;
  var status;
  var deliveryCharge;
  var totalAmount;
  var paymentMode;
  var createdAt;
  var totalKm;
  var pickedupAt;
  var deliveredAt;
  var productCount;

  Order(
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
        this.totalKm,
        this.pickedupAt,
        this.deliveredAt,
        this.productCount});

  Order.fromJson(Map<String, dynamic> json) {
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
    totalKm = json['totalKm'];
    pickedupAt = json['pickedupAt'];
    deliveredAt = json['deliveredAt'];
    productCount = json['productCount'];
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
    data['totalKm'] = this.totalKm;
    data['pickedupAt'] = this.pickedupAt;
    data['deliveredAt'] = this.deliveredAt;
    data['productCount'] = this.productCount;
    return data;
  }
}

class Pickup {
  var name;
  var address;
  var image;
  var mobileNo;
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
  var image;
  var name;
  var mobileNo;
  var address1;
  var address2;
  double? lat;
  double? long;
  var city;
  var pincode;
  var state;
  var deliveryInsturction;

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
  var name;
  var image;
  var mrp;
  var price;
  var quantity;
  var finalPrice;
  var unitOfManagement;
  var sellingUnit;

  Products(
      {this.name,
        this.image,
        this.mrp,
        this.price,
        this.quantity,
        this.finalPrice,
        this.unitOfManagement,
        this.sellingUnit});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    mrp = json['mrp'];
    price = json['price'];
    quantity = json['quantity'];
    finalPrice = json['finalPrice'];
    unitOfManagement = json['unitOfManagement'];
    sellingUnit = json['sellingUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['mrp'] = this.mrp;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['finalPrice'] = this.finalPrice;
    data['unitOfManagement'] = this.unitOfManagement;
    data['sellingUnit'] = this.sellingUnit;
    return data;
  }
}
