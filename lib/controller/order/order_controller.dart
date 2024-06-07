import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../data/datasource/remote/my_orders/my_orders.dart';
import '../../view/widget/show_message.dart';

class OrderController extends GetxController with GetTickerProviderStateMixin {
  OrderData orderController = OrderData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  final controller = Get.find<HomeScreenController>();
  String? userID;
  var size = Rx<Size>(Size.zero);

  late int initialIndex = 0;

  late RxList<OrderItemModels> processingOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> cancelledOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> shippedOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> completedOrders = RxList<OrderItemModels>([]);

  late TabController tabController;

  confirmReceived(String userOrderID) async {
    EasyLoading.show(status: "Loading", dismissOnTap: false);
    update();

    var response = await orderController.confirmReceived(userOrderID, userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        fetchOrders();
        controller.fetchTransaction();
        navigateToTab(2);
        update();
      } else {
        statusRequest = StatusRequest.failure;
        EasyLoading.dismiss();
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("Please check your internet connection and try again");
    }
    update();
  }

  fetchOrders() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderController.fetchOrders(userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> userOrderView = response['userorderview'];
        List<OrderItemModels> processedOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.status == '1')
            .toList();

        List<OrderItemModels> cancelOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.status == '4')
            .toList();
        List<OrderItemModels> shipOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) =>
                (orderModel.status == '2' || orderModel.status == '3') &&
                orderModel.receiveConfirmed != '1')
            .toList();
        List<OrderItemModels> completeOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.receiveConfirmed == '1')
            .toList();

        completeOrders.sort((a, b) {
          bool aHasReview = a.reviewID != "null";
          bool bHasReview = b.reviewID != "null";

          if (aHasReview && bHasReview) {
            return a.reviewID!.compareTo(b.reviewID!);
          } else if (aHasReview && !bHasReview) {
            return -1;
          } else if (!aHasReview && bHasReview) {
            return 1;
          } else {
            return a.dateReceived!.compareTo(b.dateReceived!);
          }
        });

        shipOrders.sort((a, b) => a.dateReceived!.compareTo(b.dateReceived!));

        processingOrders.assignAll(processedOrders.reversed.toList());
        cancelledOrders.assignAll(cancelOrders.reversed.toList());
        completedOrders.assignAll(completeOrders.reversed.toList());
        shippedOrders.assignAll(shipOrders.reversed.toList());
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  buyAgain(String? userOrderID, OrderItemModels orderItem) async {
    List<Map<String, dynamic>> orderList = [];

    for (var item in orderItem.order) {
      Map<String, dynamic> orderMap = {
        'productID': item.productID,
        'productVariationID': item.productVariationID,
        'quantity': item.quantity,
      };

      orderList.add(orderMap);
    }

    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await orderController.buyAgain(orderList, userID!);
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
    await controller.fetchTransaction();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void navigateToTab(int tabIndex) {
    tabController.animateTo(tabIndex);
  }

  @override
  void onInit() {
    initialIndex = Get.arguments?['initialIndex'] ?? 0;
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    userID = myServices.getUser()?["userID"].toString();
    tabController = TabController(length: 4, vsync: this);
    initData();
    navigateToTab(initialIndex);
    super.onInit();
  }
}
