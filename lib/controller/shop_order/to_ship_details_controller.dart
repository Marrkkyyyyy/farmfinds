import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ToShipDetailsController extends GetxController {
  late OrderItemModels orderItems;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  var size = Rx<Size>(Size.zero);
  String? orderDate;
  String? shippedDate;
  String? dateCancelled;

  int calculateMerchandiseSubtotal() {
    int merchandiseSubtotal = 0;

    for (var orderItem in orderItems.order) {
      String? price = orderItem.price;
      int? quantity = int.parse(orderItem.quantity!);
      merchandiseSubtotal += (int.parse(price!) * quantity);
    }

    return merchandiseSubtotal;
  }

  int calculateAmountPayable() {
    int totalAmountPayable = 0;

    for (var orderItem in orderItems.order) {
      String? price = orderItem.price;
      int? quantity = int.parse(orderItem.quantity!);
      totalAmountPayable += (int.parse(price!) * quantity);
    }
    totalAmountPayable += int.parse(orderItems.order[0].shippingFee!);
    return totalAmountPayable;
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    orderItems = Get.arguments['orderItems'];
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    DateTime dateTime = DateTime.parse(orderItems.orderDate!);
    // DateTime? dateTime2 = DateTime.tryParse(userOrder.dateCancelled!);
    // dateCancelled =
    //     DateFormat('yyyy-MM-dd HH:mm').format(dateTime2 ?? DateTime.now());
    orderDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    shippedDate = orderItems.dateShipped != "null"
        ? DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime.parse(orderItems.dateShipped!))
        : "";
    super.onInit();
  }
}
