import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  ShopData productController = ShopData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  var size = Rx<Size>(Size.zero);
  String? shopName;
  String? profile;
  String? shopID;
  RxString totalProcessing = "".obs;
  RxString totalShipped = "".obs;
  RxString totalCompleted = "".obs;
  RxList<ShopProductItem> shopProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> liveProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> delistedProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> violationProducts = RxList<ShopProductItem>([]);
  late BuildContext context;

  Future<void> preloadImages() async {
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

  Future<void> refreshShopProducts() async {
    await fetchShopProducts(shopID!);
  }

  fetchShopProducts(String shopID) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productController.fetchShopProducts(shopID);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> shopProductList = response['products'];

        List<ShopProductItem> allProductList = shopProductList
            .map((shopData) => ShopProductItem.fromJson(shopData))
            .toList();
        List<ShopProductItem> liveProductList = shopProductList
            .map((shopData) => ShopProductItem.fromJson(shopData))
            .where((item) => item.status == '1')
            .toList();
        List<ShopProductItem> delistedProductList = shopProductList
            .map((shopData) => ShopProductItem.fromJson(shopData))
            .where((item) => item.status == '2')
            .toList();
        List<ShopProductItem> violationProductList = shopProductList
            .map((shopData) => ShopProductItem.fromJson(shopData))
            .where((item) => item.status == '3')
            .toList();
        shopProducts.assignAll(allProductList);
        liveProducts.assignAll(liveProductList);
        delistedProducts.assignAll(delistedProductList);
        violationProducts.assignAll(violationProductList);
        totalProcessing.value =
            response['totalOrders']['totalProcessingOrders'] ?? "0";
        totalShipped.value =
            response['totalOrders']['totalShippedOrders'] ?? "0";
        totalCompleted.value =
            response['totalOrders']['totalCompletedOrders'] ?? "0";
        preloadImages();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  initialData() {
    shopName = myServices.getShop()?["shopName"];
    profile = myServices.getShop()?["profile"];
    int? shopIDInt = myServices.getShop()?["shopID"];
    shopID = shopIDInt?.toString() ?? "";
    context = Get.context!;

    fetchShopProducts(shopID!);
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
