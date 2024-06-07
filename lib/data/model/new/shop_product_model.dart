class ShopProductItem {
  String? shopID;
  String? productID;
  String? productName;
  String? productDescription;
  String? price;
  String? status;
  String? imageURL;
  String? variationIDs;
  String? variationNames;
  String? variationPrices;

  ShopProductItem(
      {this.shopID,
      this.productID,
      this.productName,
      this.productDescription,
      this.price,
      this.status,
      this.imageURL,
      this.variationIDs,
      this.variationNames,
      this.variationPrices});

  ShopProductItem.fromJson(Map<String, dynamic> json) {
    shopID = json['shopID'].toString();
    productID = json['productID'].toString();
    productName = json['productName'].toString();
    productDescription = json['productDescription'].toString();
    price = json['price'].toString();
    status = json['status'].toString();
    imageURL = json['imageURL'].toString();
    variationIDs = json['variationIDs'].toString();
    variationNames = json['variationNames'].toString();
    variationPrices = json['variationPrices'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopID'] = this.shopID;
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['price'] = this.price;
    data['status'] = this.status;
    data['imageURL'] = this.imageURL;
    data['variationIDs'] = this.variationIDs;
    data['variationNames'] = this.variationNames;
    data['variationPrices'] = this.variationPrices;
    return data;
  }
}
