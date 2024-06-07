import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/cart.dart';
import 'package:ecommerce/data/datasource/remote/home/shop.dart';
import 'package:ecommerce/data/model/new/product_review_model.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ProductProfileController extends GetxController {
  ShopData shopController = ShopData(Get.find());
  CartData cartController = CartData(Get.find());
  MyServices myServices = Get.find();
  var size = Rx<Size>(Size.zero);
  late ShopProductItem product;
  late String productID;
  RxBool isExpanded = true.obs;
  RxInt indexImage = 0.obs;
  RxInt totalSold = 0.obs;
  RxDouble totalRate = 0.0.obs;
  late List<String> variationIDs = [];
  late List<String> variationPrices = [];
  late List<String> variationNames = [];
  late RxInt currentPage = 0.obs;
  RxBool animateHero = true.obs;
  RxInt selectedIndex = 0.obs;
  final RxInt quantityCount = 1.obs;
  String? userID;
  String? shopID;
  StatusRequest statusRequest = StatusRequest.none;
  late List<String> image = [];
  late List<String> reviewImage = [];
  late BuildContext context;
  RxList<ProductReviewModel> productReviews = RxList<ProductReviewModel>([]);

  Future<void> preloadImages() async {
    for (final imageUrl in image) {
      try {
        await precacheImage(
            CachedNetworkImageProvider("${AppLink.productImage}${imageUrl}"),
            context);
      } catch (e) {}
    }
  }

  Future<void> preloadReviewImages() async {
    for (final review in productReviews) {
      final imageUrl = review.reviewImageUrl;
      if (imageUrl != "null" && imageUrl!.isNotEmpty) {
        final imageUrls = imageUrl.split(',');
        for (final url in imageUrls) {
          try {
            await precacheImage(
              CachedNetworkImageProvider("${AppLink.reviewImage}$url"),
              context,
            );
          } catch (e) {}
        }
      }
    }
  }

  fetchProductReviews(String productID) async {
    statusRequest = StatusRequest.loading;
    var response = await shopController.fetchTestProductReviews(productID);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> productReviewsList = response['viewproductreview'];
        totalSold.value = int.parse(response['totalSold'] ?? "0");
        List<ProductReviewModel> reviews = productReviewsList
            .map((shopData) => ProductReviewModel.fromJson(shopData))
            .toList();
        product = ShopProductItem.fromJson(response['productData']);
        productReviews.assignAll(reviews.reversed.toList());
        image = product.imageURL!.split(",");
        variationIDs = product.variationIDs!.split(",");
        variationPrices = product.variationPrices!.split(",");
        variationNames = product.variationNames!.split(",");
        preloadReviewImages();
        getTotalRate();
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      showErrorMessage(
          "Please check your internet connection and refresh the page");
    } else {
      showErrorMessage("Something went wrong. Please refresh the page");
    }
    update();
  }

  void getTotalRate() {
    for (var review in productReviews) {
      totalRate.value += double.parse(
        (double.parse(review.rating!) / productReviews.length)
            .toStringAsFixed(1),
      );
    }
  }

  Future<void> refreshData() async {
    await fetchProductReviews(productID);
  }

  addToCart() async {
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await cartController.addToCart(
      userID!,
      productID,
      variationIDs[selectedIndex.value],
      quantityCount.value.toString(),
    );
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Added to cart");
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

  selectedVariation(int index) {
    selectedIndex.value = index;
  }

  initialData() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    productID = Get.arguments;
    context = Get.context!;
    fetchProductReviews(productID);
    preloadImages();

    userID = myServices.getUser()?["userID"].toString();
    int? shopIDInt = myServices.getShop()?["shopID"];
    shopID = shopIDInt?.toString() ?? "";
  }

  void toggleExpansion() {
    isExpanded.toggle();
  }

  @override
  void onInit() {
    initialData();
    super.onInit();
  }
}
