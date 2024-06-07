class ReviewModels {
  Map<String, List<UserReviewModel>> items;

  ReviewModels({required this.items});

  factory ReviewModels.fromJson(Map<String, dynamic> json) {
    Map<String, List<UserReviewModel>> reviewItems =
        Map<String, List<UserReviewModel>>();
    json.forEach((key, value) {
      List<UserReviewModel> itemList = (value as List)
          .map((item) => UserReviewModel.fromJson(item))
          .toList();
      reviewItems[key] = itemList;
    });
    return ReviewModels(items: reviewItems);
  }
}

class UserReviewModel {
  String? reviewID;
  String? orderID;
  String? userID;
  String? productID;
  String? comment;
  String? rating;
  String? reviewDate;
  String? dateDiff;
  String? productVariationID;
  String? variationName;
  String? productName;
  String? shopID;
  String? fullName;
  String? productImageURL;
  String? reviewImageURL;

  UserReviewModel(
      {this.reviewID,
      this.orderID,
      this.userID,
      this.productID,
      this.comment,
      this.rating,
      this.reviewDate,
      this.dateDiff,
      this.productVariationID,
      this.variationName,
      this.productName,
      this.shopID,
      this.fullName,
      this.productImageURL,
      this.reviewImageURL});

  UserReviewModel.fromJson(Map<String, dynamic> json) {
    reviewID = json['reviewID'].toString();
    orderID = json['orderID'].toString();
    userID = json['userID'].toString();
    productID = json['productID'].toString();
    comment = json['comment'].toString();
    rating = json['rating'].toString();
    reviewDate = json['reviewDate'].toString();
    dateDiff = json['dateDiff'].toString();
    productVariationID = json['productVariationID'].toString();
    variationName = json['variationName'].toString();
    productName = json['productName'].toString();
    shopID = json['shopID'].toString();
    fullName = json['fullName'].toString();
    productImageURL = json['productImageURL'].toString();
    reviewImageURL = json['reviewImageURL'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviewID'] = this.reviewID;
    data['orderID'] = this.orderID;
    data['userID'] = this.userID;
    data['productID'] = this.productID;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['reviewDate'] = this.reviewDate;
    data['dateDiff'] = this.dateDiff;
    data['productVariationID'] = this.productVariationID;
    data['variationName'] = this.variationName;
    data['productName'] = this.productName;
    data['shopID'] = this.shopID;
    data['fullName'] = this.fullName;
    data['productImageURL'] = this.productImageURL;
    data['reviewImageURL'] = this.reviewImageURL;
    return data;
  }
}
