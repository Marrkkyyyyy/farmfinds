import 'package:ecommerce/controller/shop/shop/shop_controller.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';

class ProductStatusController extends GetxController {
  var size = Rx<Size>(Size.zero);
  ShopData productController = ShopData(Get.find());
  final controller = Get.find<ShopController>();
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  String? shopID;
  late List<String> imageUrls = [];
  RxList<ShopProductItem> shopProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> liveProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> delistedProducts = RxList<ShopProductItem>([]);
  RxList<ShopProductItem> violationProducts = RxList<ShopProductItem>([]);

  Future<void> refreshData() async {
    await fetchProducts(shopID!);
  }

  publishProduct(String productID) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productController.publishProduct(productID);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Publish Product Successfully");

        ShopProductItem? productToPublish = delistedProducts.firstWhere(
          (product) => product.productID == productID,
        );
        delistedProducts.remove(productToPublish);
        liveProducts.add(productToPublish);
        update();

        controller.refreshShopProducts();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  delistProduct(String productID) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await productController.delistProduct(productID);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Delisted Product Successfully");

        ShopProductItem? productToRemove = liveProducts.firstWhere(
          (product) => product.productID == productID,
        );
        liveProducts.remove(productToRemove);
        delistedProducts.add(productToRemove);
        update();

        controller.refreshShopProducts();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  fetchProducts(String shopID) async {
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
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  initData() async {
    await fetchProducts(shopID!);
  }

  @override
  void onInit() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    shopID = myServices.getShop()?["shopID"].toString();
    initData();
    super.onInit();
  }
}
