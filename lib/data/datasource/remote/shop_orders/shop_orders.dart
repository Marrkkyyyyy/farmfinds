import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class ShopOrderData {
  Crud crud;
  ShopOrderData(this.crud);

  fetchShopOrder(String shopID) async {
    var response =
        await crud.postData(AppLink.fetchShopOrder, {"shopID": shopID});
    return response.fold((l) => l, (r) => r);
  }
}
