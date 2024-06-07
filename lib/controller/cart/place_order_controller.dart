import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../data/datasource/remote/home/cart.dart';

class PlaceOrderController extends GetxController {
  CartData controller = CartData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  var size = Rx<Size>(Size.zero);
  RxInt addressID = 0.obs;

  String? fullName;
  String? phoneNumber;
  String? streetName;
  String? barangay;
  String? city;
  String? province;
  String? postalCode;
  Map<String, List<CartItem>> shopItems = {};
  List<CartItem> orderItem = [];
  RxList<CartItem> products = RxList<CartItem>([]);

  RxInt totalPayment = 0.obs;
  RxInt TotalShippingFee = 0.obs;
  RxInt TotalMerchandise = 0.obs;
  String? userID;
  int shippingFee = 25;

  checkout() {
    orderItem = [];
    shopItems.forEach((shopName, cartItems) {
      orderItem.assignAll(cartItems);
    });

    List<Map<String, dynamic>> toJsonList() {
      return orderItem.map((item) => item.toJson()).toList();
    }

    PlaceOrder(toJsonList());
  }

  void PlaceOrder(orderItem) async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await controller.placeOrder(
        orderItem, userID!, addressID.value, shippingFee.toString());

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.showSuccess(
          "Your order has been placed successfully",
          dismissOnTap: false,
        );

        Future.delayed(Duration(seconds: 1), () {
          Get.offAllNamed(AppRoute.home);
        });
        EasyLoading.dismiss();
      }
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
      EasyLoading.dismiss();
    } else if (StatusRequest.offlinefailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();
    update();
  }

  calculateTotalPayment() {
    for (var shopName in shopItems.keys) {
      for (var product in shopItems[shopName]!) {
        String? price = product.price == null || product.price == "null"
            ? product.originalPrice
            : product.price;
        totalPayment.value += int.parse(price!) * int.parse(product.quantity!);
        TotalMerchandise.value +=
            int.parse(price) * int.parse(product.quantity!);
      }
      totalPayment.value += 25;
      TotalShippingFee.value += 25;
    }
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    fullName = myServices.getAddress()?["fullName"];
    phoneNumber = myServices.getAddress()?["phoneNumber"];
    streetName = myServices.getAddress()?["streetName"];
    barangay = myServices.getAddress()?["barangay"];
    city = myServices.getAddress()?["city"];
    province = myServices.getAddress()?["province"];
    postalCode = myServices.getAddress()?["postalCode"].toString();

    shopItems = Get.arguments['item'];
    calculateTotalPayment();
    addressID.value = myServices.getAddress()?["addressID"] ?? 0;
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }
}
