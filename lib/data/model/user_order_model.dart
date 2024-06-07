class UserOrderModel {
  String? userOrderID;
  String? orderID;
  String? userID;
  String? orderDate;
  String? status;
  String? dateCancelled;
  String? dateReceived;
  String? dateShipped;
  String? shippingAddressID;
  String? pickupAddressID;
  String? shippingFee;
  String? subtotal;
  String? deliveryPersonID;
  String? productID;
  String? productName;
  String? variationName;
  String? productImageURL;
  String? reviewID;
  String? receiveConfirmed;
  String? deliveryFullname;
  String? deliveryPhoneNumber;
  String? shopID;
  String? shopName;
  String? fullName;
  String? phoneNumber;
  String? region;
  String? province;
  String? city;
  String? barangay;
  String? postalCode;
  String? streetName;

  UserOrderModel(
      {this.userOrderID,
      this.orderID,
      this.userID,
      this.orderDate,
      this.status,
      this.shippingAddressID,
      this.pickupAddressID,
      this.shippingFee,
      this.subtotal,
      this.deliveryPersonID,
      this.productID,
      this.productName,
      this.variationName,
      this.productImageURL,
      this.reviewID,
      this.receiveConfirmed,
      this.deliveryFullname,
      this.deliveryPhoneNumber,
      this.shopID,
      this.shopName,
      this.fullName,
      this.phoneNumber,
      this.region,
      this.province,
      this.city,
      this.barangay,
      this.postalCode,
      this.streetName});

  UserOrderModel.fromJson(Map<String, dynamic> json) {
    userOrderID = json['userOrderID'].toString();
    orderID = json['orderID'].toString();
    userID = json['userID'].toString();
    orderDate = json['orderDate'];
    status = json['status'].toString();
    dateCancelled = json['dateCancelled'].toString();
    dateReceived = json['dateReceived'].toString();
    dateShipped = json['dateShipped'].toString();
    shippingAddressID = json['shippingAddressID'].toString();
    pickupAddressID = json['pickupAddressID'].toString();
    shippingFee = json['shippingFee'].toString();
    subtotal = json['subtotal'].toString();
    deliveryPersonID = json['deliveryPersonID'].toString();
    productID = json['productID'].toString();
    productName = json['productName'].toString();
    variationName = json['variationName'].toString();
    productImageURL = json['productImageURL'].toString();
    reviewID = json['reviewID'].toString();
    receiveConfirmed = json['receiveConfirmed'].toString();
    deliveryFullname = json['deliveryFullname'].toString();
    deliveryPhoneNumber = json['deliveryPhoneNumber'].toString();
    shopID = json['shopID'].toString();
    shopName = json['shopName'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'].toString();
    region = json['region'];
    province = json['province'];
    city = json['city'];
    barangay = json['barangay'];
    postalCode = json['postalCode'].toString();
    streetName = json['streetName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userOrderID'] = this.userOrderID;
    data['orderID'] = this.orderID;
    data['userID'] = this.userID;
    data['orderDate'] = this.orderDate;
    data['status'] = this.status;
    data['dateCancelled'] = this.dateCancelled;
    data['dateReceived'] = this.dateReceived;
    data['dateShipped'] = this.dateShipped;
    data['shippingAddressID'] = this.shippingAddressID;
    data['pickupAddressID'] = this.pickupAddressID;
    data['shippingFee'] = this.shippingFee;
    data['subtotal'] = this.subtotal;
    data['deliveryPersonID'] = this.deliveryPersonID;
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['variationName'] = this.variationName;
    data['productImageURL'] = this.productImageURL;
    data['reviewID'] = this.reviewID;
    data['receiveConfirmed'] = this.receiveConfirmed;
    data['deliveryFullname'] = this.deliveryFullname;
    data['deliveryPhoneNumber'] = this.deliveryPhoneNumber;
    data['shopID'] = this.shopID;
    data['shopName'] = this.shopName;
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['region'] = this.region;
    data['province'] = this.province;
    data['city'] = this.city;
    data['barangay'] = this.barangay;
    data['postalCode'] = this.postalCode;
    data['streetName'] = this.streetName;
    return data;
  }
}
