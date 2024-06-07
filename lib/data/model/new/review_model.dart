class ReviewModel {
  String? orderID;
  String? userID;
  String? comment;
  String? rating;
  String? reviewDate;
  String? fullName;
  String? dateDiff;
  String? reviewImageUrl;
  List<ReviewItem> order;

  ReviewModel({
    this.orderID,
    this.userID,
    this.comment,
    this.rating,
    this.reviewDate,
    this.fullName,
    this.dateDiff,
    this.reviewImageUrl,
    required this.order,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    List<ReviewItem> orderItems = [];
    if (json['order'] != null) {
      orderItems = List<ReviewItem>.from(
          json['order'].map((item) => ReviewItem.fromJson(item)));
    }
    return ReviewModel(
      orderID: json['orderID'].toString(),
      userID: json['userID'].toString(),
      comment: json['comment'].toString(),
      rating: json['rating'].toString(),
      reviewDate: json['reviewDate'].toString(),
      fullName: json['fullName'].toString(),
      dateDiff: json['dateDiff'].toString(),
      reviewImageUrl: json['reviewImageUrl'].toString(),
      order: orderItems,
    );
  }
}

class ReviewItem {
  String? reviewID;
  String? productID;
  String? productVariationID;
  String? productImageUrl;
  String? productName;
  String? variationName;

  ReviewItem({
    this.reviewID,
    this.productID,
    this.productVariationID,
    this.productImageUrl,
    this.productName,
    this.variationName,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'].toString(),
      productID: json['productID'].toString(),
      productVariationID: json['productVariationID'].toString(),
      productImageUrl: json['productImageUrl'].toString(),
      productName: json['productName'].toString(),
      variationName: json['variationName'].toString(),
    );
  }
}
