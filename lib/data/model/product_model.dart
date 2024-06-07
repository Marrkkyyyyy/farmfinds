class ProductModel {
  String? productID;
  String? shopID;
  String? productName;
  String? productDescription;
  String? price;
  String? status;
  String? views;
  String? imageURL;
  String? variationIDs;
  String? variationNames;
  String? variationPrices;

  ProductModel(
      {this.productID,
      this.shopID,
      this.productName,
      this.productDescription,
      this.price,
      this.status,
      this.views,
      this.imageURL,
      this.variationIDs,
      this.variationNames,
      this.variationPrices});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'].toString();
    shopID = json['shopID'].toString();
    productName = json['productName'];
    productDescription = json['productDescription'];
    price = json['price'].toString();
    status = json['status'].toString();
    views = json['views'].toString();
    imageURL = json['imageURL'];
    variationIDs = json['variationIDs'].toString();
    variationNames = json['variationNames'].toString();
    variationPrices = json['variationPrices'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['shopID'] = this.shopID;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['price'] = this.price;
    data['status'] = this.status;
    data['views'] = this.views;
    data['imageURL'] = this.imageURL;
    data['variationIDs'] = this.variationIDs;
    data['variationNames'] = this.variationNames;
    data['variationPrices'] = this.variationPrices;
    return data;
  }
}
