import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:ecommerce/data/model/shop_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  MyServices myServices = Get.find();
  String? userID;
  ShopData shopController = ShopData(Get.find());
  var size = Rx<Size>(Size.zero);
  late ShopModel shops;
  StatusRequest statusRequest = StatusRequest.none;
  RxList<ShopProductItem> shopProducts = RxList<ShopProductItem>([]);
  late BuildContext context;
  late RxDouble totalShopRate = 0.0.obs;

  Future<void> preloadShopProfileImages() async {
    for (final shop in shopProducts) {
      final imageUrl = shop.imageURL?.split(",")[0];
      if (imageUrl != null) {
        try {
          await precacheImage(
              CachedNetworkImageProvider("${AppLink.productImage}${imageUrl}"),
              context);
        } catch (e) {}
      }
    }
  }

  fetchShopProducts(String shopID) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopController.fetchShopProducts(shopID);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> shopProductList = response['products'];
        List<ShopProductItem> productList = shopProductList
            .map((shopData) => ShopProductItem.fromJson(shopData))
            .toList();
        shopProducts.assignAll(productList);
        preloadShopProfileImages();
        if (response['totalRating']['totalRating'] == 0 ||
            response['totalRating']['totalRating'] == null) {
          totalShopRate.value = 0.0;
        } else {
          totalShopRate.value = double.parse((response['totalRating']
                      ['totalRating'] /
                  response['totalRating']['totalRows'])
              .toStringAsFixed(1));
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> refreshData() async {
    await fetchShopProducts(shops.shopID.toString());
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    context = Get.context!;
    shops = Get.arguments;
    fetchShopProducts(shops.shopID.toString());
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }
}
