import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/home/cart.dart';
import 'package:ecommerce/data/model/cart_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  CartData cartController = CartData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  var size = Rx<Size>(Size.zero);
  String? userID;

  Map<String, List<CartItem>> shopItemsMap = Map();
  RxList<CartItem> products = RxList<CartItem>([]);

  Map<String, bool> checkedItems = {};
  Map<String, List<CartItem>> selected = {};
  RxInt totalPrice = 0.obs;
  List<CartItem> selectedItems = [];
  RxInt total = 0.obs;
  RxInt totalCart = 0.obs;

  RxBool isCalculated = true.obs;
  late BuildContext context;
  void toggleCheckbox(CartItem item, String shopName) {
    if (checkedItems.containsKey(item.cartID)) {
      checkedItems.remove(item.cartID);
      selectedItems.remove(item);
      if (selected.containsKey(shopName)) {
        selected[shopName]!.remove(item);
        if (selected[shopName]!.isEmpty) {
          selected.remove(shopName);
        }
      }
    } else {
      checkedItems[item.cartID!] = true;
      selectedItems.add(item);
      if (selected.containsKey(shopName)) {
        selected[shopName]!.add(item);
      } else {
        selected[shopName] = [item];
      }
    }
    calculateTotalPrice();
    update();
  }

  calculateTotalPrice() {
    total.value = 0;
    for (var item in selectedItems) {
      String? price = item.price == null || item.price == "null"
          ? item.originalPrice
          : item.price;
      total += int.parse(price!) * int.parse(item.quantity!);
    }
    isCalculated.value = true;
  }

  Future<bool> deleteCart(String cartID, String shopName) async {
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await cartController.deleteCart(cartID);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (shopItemsMap.containsKey(shopName)) {
          var products = shopItemsMap[shopName];
          if (products!.length == 1) {
            totalCart.value = totalCart.value - 1;
            shopItemsMap.remove(shopName);
          } else {
            totalCart.value = totalCart.value - 1;
            products.removeWhere((item) => item.cartID == cartID);
          }
        }

        update();
        showSuccessMessage("Product removed");
        EasyLoading.dismiss();
        return true;
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
    }
    return false;
  }

  Future<bool> updateQuantity(String cartID, String quantity) async {
    var response = await cartController.updateQuantity(cartID, quantity);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        return true;
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      showErrorMessage("Please check your internet connection and try again");
    }
    return false;
  }

  fetchShops() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await cartController.fetchCart(userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        totalCart.value = response['totalCart'];
        CartModel cartModel = CartModel.fromJson(response['shopItems']);

        cartModel.items.forEach((shopName, products) async {
          Map<int, List<CartItem>> groupedProducts = {};
          products.forEach((product) {
            int productId = int.parse(product.productID!);
            if (!groupedProducts.containsKey(productId)) {
              groupedProducts[productId] = [];
            }
            groupedProducts[productId]!.add(product);
          });

          groupedProducts.forEach((productId, productList) {
            productList.sort((a, b) => a.cartID!.compareTo(b.cartID!));
          });

          List<CartItem> sortedProducts = [];
          groupedProducts.values.forEach((productList) {
            sortedProducts.addAll(productList);
          });

          shopItemsMap[shopName] = sortedProducts;

          preloadImages(sortedProducts);
        });
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<void> preloadImages(products) async {
    for (final product in products) {
      final imageUrl = product.imageURL;

      if (imageUrl != null) {
        try {
          await precacheImage(
              CachedNetworkImageProvider("${AppLink.productImage}${imageUrl}"),
              context);
        } catch (e) {
          print('Error preloading shop profile image: $e');
        }
      }
    }
  }

  @override
  void onInit() {
    context = Get.context!;
    userID = myServices.getUser()?["userID"].toString();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    fetchShops();
    super.onInit();
  }
}
