class OrderItemModels {
  String? userOrderID;
  String? orderID;
  String? shopName;
  String? orderDate;
  String? dateCancelled;
  String? dateReceived;
  String? dateShipped;
  String? userID;
  String? shippingAddressID;
  String? pickupAddressID;
  String? subtotal;
  String? deliveryPersonID;
  String? status;
  String? receiveConfirmed;
  String? deliveryPhoneNumber;
  String? deliveryFullName;
  String? reviewID;
  List<OrderItem> order;

  OrderItemModels({
    this.userOrderID,
    this.orderID,
    this.shopName,
    this.orderDate,
    this.dateCancelled,
    this.dateReceived,
    this.dateShipped,
    this.userID,
    this.shippingAddressID,
    this.pickupAddressID,
    this.subtotal,
    this.deliveryPersonID,
    this.status,
    this.receiveConfirmed,
    this.deliveryPhoneNumber,
    this.deliveryFullName,
    this.reviewID,
    required this.order,
  });

  factory OrderItemModels.fromJson(Map<String, dynamic> json) {
    List<OrderItem> orderItems = [];
    if (json['order'] != null) {
      orderItems = List<OrderItem>.from(
          json['order'].map((item) => OrderItem.fromJson(item)));
    }
    return OrderItemModels(
      userOrderID: json['userOrderID'].toString(),
      orderID: json['orderID'].toString(),
      shopName: json['shopName'].toString(),
      orderDate: json['orderDate'].toString(),
      dateCancelled: json['dateCancelled'].toString(),
      dateReceived: json['dateReceived'].toString(),
      dateShipped: json['dateShipped'].toString(),
      userID: json['userID'].toString(),
      shippingAddressID: json['shippingAddressID'].toString(),
      pickupAddressID: json['pickupAddressID'].toString(),
      subtotal: json['subtotal'].toString(),
      deliveryPersonID: json['deliveryPersonID'].toString(),
      status: json['status'].toString(),
      receiveConfirmed: json['receiveConfirmed'].toString(),
      deliveryPhoneNumber: json['deliveryPhoneNumber'].toString(),
      deliveryFullName: json['deliveryFullName'].toString(),
      reviewID: json['reviewID'].toString(),
      order: orderItems,
    );
  }
}

class OrderItem {
  String? orderItemID;
  String? productID;
  String? productVariationID;
  String? productImageURL;
  String? price;
  String? quantity;
  String? shippingFee;
  String? productName;
  String? variationName;

  OrderItem({
    this.orderItemID,
    this.productID,
    this.productVariationID,
    this.productImageURL,
    this.price,
    this.quantity,
    this.shippingFee,
    this.productName,
    this.variationName,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      orderItemID: json['orderItemID'].toString(),
      productID: json['productID'].toString(),
      productVariationID: json['productVariationID'].toString(),
      productImageURL: json['productImageURL'].toString(),
      price: json['price'].toString(),
      quantity: json['quantity'].toString(),
      shippingFee: json['shippingFee'].toString(),
      productName: json['productName'].toString(),
      variationName: json['variationName'].toString(),
    );
  }
}
