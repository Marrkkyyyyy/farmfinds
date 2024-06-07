import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/data/model/new/review_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../core/class/status_request.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/reviews/review.dart';
import '../../data/model/order_item_model.dart';

class ToReviewController extends GetxController {
  ReviewData reviewController = ReviewData(Get.find());
  MyServices myServices = Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  late String? userID;
  late String? fullName;
  late String? userProfile;
  var size = Rx<Size>(Size.zero);
  late RxInt currentPage = 0.obs;

  late RxList<OrderItemModels> toRateOrders = RxList<OrderItemModels>([]);
  late RxList<ReviewModel> myReviews = RxList<ReviewModel>([]);
  fetchOrders() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await reviewController.fetchOrders(userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> userOrderView = response['userorderview'];
        List<OrderItemModels> toRateOrderList = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) =>
                orderModel.reviewID == "null" &&
                orderModel.receiveConfirmed == "1")
            .toList();
        toRateOrders.assignAll(toRateOrderList.reversed.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  fetchReviews() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await reviewController.fetchReviews(userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> myReviewList = response['viewreview'];
        myReviews.assignAll(
            myReviewList.map((shopData) => ReviewModel.fromJson(shopData)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  buyAgain(String? userOrderID, RxList<OrderItemModel> orderItem) async {
    List<OrderItemModel> orderItems =
        orderItem.where((item) => item.userOrderID == userOrderID).toList();
    List<Map<String, dynamic>> orderList = [];
    for (OrderItemModel orderItemModel in orderItems) {
      Map<String, dynamic> orderMap = {
        'productID': orderItemModel.productID,
        'productVariationID': orderItemModel.productVariationID,
        'quantity': orderItemModel.quantity,
      };

      orderList.add(orderMap);
    }

    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await reviewController.buyAgain(orderList, userID!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.toNamed(AppRoute.cartPage);
      } else {
        statusRequest = StatusRequest.failure;
        EasyLoading.dismiss();
      }
      EasyLoading.dismiss();
    }
    update();
  }



  initData() async {
    await fetchOrders();
    await fetchReviews();
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    fullName = myServices.getUser()?["fullName"].toString();
    userProfile = myServices.getUser()?["userProfile"] ?? "";
    initData();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
