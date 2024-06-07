class OrderItemModel {
  String? orderItemID;
  String? userOrderID;
  String? productID;
  String? productVariationID;
  String? productImageURL;
  String? price;
  String? quantity;
  String? userID;
  String? status;
  String? productName;
  String? productDescription;
  String? variationName;

  OrderItemModel(
      {this.orderItemID,
      this.userOrderID,
      this.productID,
      this.productVariationID,
      this.productImageURL,
      this.price,
      this.quantity,
      this.userID,
      this.status,
      this.productName,
      this.productDescription,
      this.variationName});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    orderItemID = json['orderItemID'].toString();
    userOrderID = json['userOrderID'].toString();
    productID = json['productID'].toString();
    productVariationID = json['productVariationID'].toString();
    productImageURL = json['productImageURL'];
    price = json['price'].toString();
    quantity = json['quantity'].toString();
    userID = json['userID'].toString();
    status = json['status'].toString();
    productName = json['productName'];
    productDescription = json['productDescription'];
    variationName = json['variationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderItemID'] = this.orderItemID;
    data['userOrderID'] = this.userOrderID;
    data['productID'] = this.productID;
    data['productVariationID'] = this.productVariationID;
    data['productImageURL'] = this.productImageURL;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['userID'] = this.userID;
    data['status'] = this.status;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['variationName'] = this.variationName;
    return data;
  }
}
