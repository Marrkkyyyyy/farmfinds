import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class ShopData {
  Crud crud;
  ShopData(this.crud);

  fetchVersion() async {
    var response = await crud.postData(AppLink.appVersion, {});
    return response.fold((l) => l, (r) => r);
  }

  fetchShops() async {
    var response = await crud.postData(AppLink.shops, {});
    return response.fold((l) => l, (r) => r);
  }

  fetchShopProducts(String shopID) async {
    var response =
        await crud.postData(AppLink.shopTestProducts, {"shopID": shopID});
    return response.fold((l) => l, (r) => r);
  }

  publishProduct(String productID) async {
    var response =
        await crud.postData(AppLink.publishProduct, {"productID": productID});
    return response.fold((l) => l, (r) => r);
  }

  delistProduct(String productID) async {
    var response =
        await crud.postData(AppLink.delistProduct, {"productID": productID});
    return response.fold((l) => l, (r) => r);
  }

  fetchProducts(String shopID) async {
    var response =
        await crud.postData(AppLink.fetchProducts, {"shopID": shopID});
    return response.fold((l) => l, (r) => r);
  }

  fetchOrders(String userID) async {
    var response = await crud.postData(AppLink.fetchOrders, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  fetchTestProductReviews(String productID) async {
    var response = await crud
        .postData(AppLink.fetchTestProductReviews, {"productID": productID});
    return response.fold((l) => l, (r) => r);
  }
}
