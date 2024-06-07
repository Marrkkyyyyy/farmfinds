import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/my_orders/my_orders.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailsController extends GetxController {
  late OrderItemModels orderItems;
  final homeController = Get.find<HomeScreenController>();
  OrderData orderController = OrderData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  var size = Rx<Size>(Size.zero);
  String? orderDate;
  String? shippedDate;
  String? dateReceived;
  String? dateCancelled;
  String? DateToday;

  void rateExperience(userOrderID) async {
    EasyLoading.show(status: "Loading", dismissOnTap: false);
    update();

    var response = await orderController.confirmReceived(userOrderID, userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        Get.back(result: true);
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

  int calculateMerchandiseSubtotal() {
    int merchandiseSubtotal = 0;

    for (var orderItem in orderItems.order) {
      String? price = orderItem.price;
      int? quantity = int.parse(orderItem.quantity!);
      merchandiseSubtotal += (int.parse(price!) * quantity);
    }

    return merchandiseSubtotal;
  }

  cancelOrder() async {
    EasyLoading.show(status: "Loading", dismissOnTap: false);
    statusRequest = StatusRequest.loading;
    update();
    var response = await orderController.cancelOrder(orderItems.userOrderID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.showSuccess(
          "Successfully Cancelled",
          dismissOnTap: false,
        );
        homeController.fetchTransaction();
        EasyLoading.dismiss();
        Future.delayed(Duration(seconds: 1), () {
          Get.back(result: true);
        });
      } else {
        statusRequest = StatusRequest.failure;
        EasyLoading.dismiss();
      }
      EasyLoading.dismiss();
    } else if (StatusRequest.offlinefailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("Please check your internet connection and try again");
    } else {
      EasyLoading.dismiss();
    }
    update();
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    orderItems = Get.arguments['orderItems'];
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(orderItems.orderDate!);
    orderDate = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
    DateTime? dateTime2 = DateTime.tryParse(orderItems.dateCancelled!);
    dateCancelled = DateFormat('yyyy-MM-dd HH:mm').format(dateTime2 ?? now);
    DateToday = DateFormat('dd-MM-yyyy').format(now);
    shippedDate = orderItems.dateShipped != "null"
        ? DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime.parse(orderItems.dateShipped!))
        : "";
    dateReceived = orderItems.dateReceived != "null"
        ? DateFormat('yyyy-MM-dd HH:mm')
            .format(DateTime.parse(orderItems.dateReceived!))
        : "";

    super.onInit();
  }
}
