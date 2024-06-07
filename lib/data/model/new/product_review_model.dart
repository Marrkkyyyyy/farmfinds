class ProductReviewModel {
  String? orderID;
  String? comment;
  String? rating;
  String? reviewDate;
  String? fullName;
  String? reviewImageUrl;
  List<ProductReviewItem> review;

  ProductReviewModel({
    this.orderID,
    this.comment,
    this.rating,
    this.reviewDate,
    this.fullName,
    this.reviewImageUrl,
    required this.review,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    List<ProductReviewItem> reviewItems = [];
    if (json['review'] != null) {
      reviewItems = List<ProductReviewItem>.from(
          json['review'].map((item) => ProductReviewItem.fromJson(item)));
    }
    return ProductReviewModel(
      orderID: json['orderID'].toString(),
      comment: json['comment'].toString(),
      rating: json['rating'].toString(),
      reviewDate: json['reviewDate'].toString(),
      fullName: json['fullName'].toString(),
      reviewImageUrl: json['reviewImageUrl'].toString(),
      review: reviewItems,
    );
  }
}

class ProductReviewItem {
  String? reviewID;
  String? productID;
  String? shopID;
  String? productImageUrl;
  String? variationName;

  ProductReviewItem({
    this.reviewID,
    this.productID,
    this.shopID,
    this.productImageUrl,
    this.variationName,
  });

  factory ProductReviewItem.fromJson(Map<String, dynamic> json) {
    return ProductReviewItem(
      reviewID: json['reviewID'].toString(),
      productID: json['productID'].toString(),
      shopID: json['shopID'].toString(),
      productImageUrl: json['productImageUrl'].toString(),
      variationName: json['variationName'].toString(),
    );
  }
}
