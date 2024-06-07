import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/shop_orders/shop_orders.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopOrderController extends GetxController {
  var size = Rx<Size>(Size.zero);
  ShopOrderData shopOrderController = ShopOrderData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? shopID;
  int initialIndex = 0;

  late RxList<OrderItemModels> processingOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> shippedOrders = RxList<OrderItemModels>([]);
  late RxList<OrderItemModels> completedOrders = RxList<OrderItemModels>([]);

  fetchShopOrder() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopOrderController.fetchShopOrder(shopID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> userOrderView = response['userorderview'];
        List<OrderItemModels> processedOrders = userOrderView
            .map((shopData) => OrderItemModels.fromJson(shopData))
            .where((orderModel) => orderModel.status == '1')
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

        processingOrders.assignAll(processedOrders);
        shippedOrders.assignAll(shipOrders);
        completedOrders.assignAll(completeOrders);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  // fetchShopOrder() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await shopOrderController.fetchShopOrder(shopID!);

  //   statusRequest = handlingData(response);
  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       toShipOrders.value = (response['processOrder'] as List)
  //           .map((orderData) => UserOrderModel.fromJson(orderData))
  //           .toList();

  //       toShipOrderItem.value = (response['processOrderItem'] as List)
  //           .map((orderData) => OrderItemModel.fromJson(orderData))
  //           .toList();

  //       shippedUserOrders.value = (response['shippedOrder'] as List)
  //           .map((orderData) => UserOrderModel.fromJson(orderData))
  //           .toList();

  //       shippedOrderItem.value = (response['shippedOrderItem'] as List)
  //           .map((orderData) => OrderItemModel.fromJson(orderData))
  //           .toList();

  //       completedUserOrders.value = (response['completedOrder'] as List)
  //           .map((orderData) => UserOrderModel.fromJson(orderData))
  //           .toList();

  //       completedOrderItem.value = (response['completedOrderItem'] as List)
  //           .map((orderData) => OrderItemModel.fromJson(orderData))
  //           .toList();
  //     } else {
  //       statusRequest = StatusRequest.failure;
  //     }
  //   }
  //   update();
  // }

  initData() async {
    await fetchShopOrder();
  }

  @override
  void onInit() {
    int? shopIDInt = myServices.getShop()?["shopID"];
    shopID = shopIDInt?.toString() ?? "";
    initialIndex = Get.arguments?['initialIndex'] ?? 0;
    initData();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }
}
