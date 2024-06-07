import 'dart:convert';
import 'dart:io';

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';
import 'package:get/get.dart';

class ReviewData {
  Crud crud;
  ReviewData(this.crud);

  fetchOrders(String userID) async {
    var response = await crud.postData(AppLink.fetchOrders, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  submitFeedback(
      String orderID,
      String userID,
      List<String> productID,
      List<String> variationID,
      List<String> productImageUrl,
      String rating,
      String comment,
      RxList<File?> images) async {
    var response = await crud.postImageData(AppLink.submitFeedback, {
      'orderID': orderID,
      'userID': userID,
      'productID': productID,
      'variationID': variationID,
      'productImageUrl': json.encode(productImageUrl),
      'comment': comment,
      'rating': rating,
      'image': images,
    });

    return response.fold((l) => l, (r) => r);
  }

  updateFeedback(String orderID, String userID, String comment, String rating,
      RxList<File?> images, reviewImages) async {
    var response = await crud.postImageData(AppLink.updateFeedback, {
      'orderID': orderID,
      'userID': userID,
      'rating': rating,
      'comment': comment,
      'image': images,
      'reviewImage': jsonEncode(reviewImages)
    });
    return response.fold((l) => l, (r) => r);
  }

  buyAgain(orderitem, String userID) async {
    var response = await crud.postData(AppLink.buyAgain,
        {"userID": userID, "orderItem": jsonEncode(orderitem)});
    return response.fold((l) => l, (r) => r);
  }

  
  fetchReviews(String userID) async {
    var response = await crud.postData(AppLink.fetchReviews, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }
}
