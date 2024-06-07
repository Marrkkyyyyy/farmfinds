import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/shop_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopHomeController extends GetxController {
  MyServices myServices = Get.find();
  String? userID;
  ShopData productController = ShopData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  RxList<ShopModel> shops = RxList<ShopModel>([]);
  late BuildContext context;

  Future<void> preloadImages() async {
    for (final shop in shops) {
      final imageUrl = shop.profile;

      if (imageUrl != null) {
        try {
          await precacheImage(
              CachedNetworkImageProvider("${AppLink.shopImage}${imageUrl}"),
              context);
        } catch (e) {}
      }
    }
  }

  fetchShops() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productController.fetchShops();

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> shopDataList = response['shops'];
        shops.addAll(
            shopDataList.map((shopData) => ShopModel.fromJson(shopData)));
        preloadImages();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> refreshData() async {
    shops.clear();
    await fetchShops();
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    context = Get.context!;
    fetchShops();

    super.onInit();
  }
}
