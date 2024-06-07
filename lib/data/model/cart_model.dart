class CartModel {
  Map<String, List<CartItem>> items;

  CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<CartItem>> cartItems = Map<String, List<CartItem>>();
    json.forEach((key, value) {
      List<CartItem> itemList =
          (value as List).map((item) => CartItem.fromJson(item)).toList();
      cartItems[key] = itemList;
    });
    return CartModel(items: cartItems);
  }
}

class CartItem {
  String? cartID;
  String? userID;
  String? productID;
  String? productVariationID;
  String? quantity;
  String? shopID;
  String? pickupAddressID;
  String? productName;
  String? originalPrice;
  String? variationName;
  String? price;
  String? imageURL;

  CartItem({
    required this.cartID,
    required this.userID,
    required this.productID,
    required this.productVariationID,
    required this.quantity,
    required this.shopID,
    required this.pickupAddressID,
    required this.productName,
    required this.originalPrice,
    required this.variationName,
    required this.price,
    required this.imageURL,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartID: json['cartID'].toString(),
      userID: json['userID'].toString(),
      productID: json['productID'].toString(),
      productVariationID: json['productVariationID'].toString(),
      quantity: json['quantity'].toString(),
      shopID: json['shopID'].toString(),
      pickupAddressID: json['pickupAddressID'].toString(),
      productName: json['productName'],
      originalPrice: json['originalPrice'].toString(),
      variationName: json['variationName'],
      price: json['price'].toString(),
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartID': cartID,
      'userID': userID,
      'productID': productID,
      'productVariationID': productVariationID,
      'quantity': quantity,
      'shopID': shopID,
      'pickupAddressID': pickupAddressID,
      'productName': productName,
      'originalPrice': originalPrice,
      'variationName': variationName,
      'price': price,
      'imageURL': imageURL,
    };
  }
}
