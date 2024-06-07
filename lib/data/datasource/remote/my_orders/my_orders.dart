import 'dart:convert';

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class OrderData {
  Crud crud;
  OrderData(this.crud);

  confirmReceived(String userOrderID, String userID) async {
    var response = await crud.postData(AppLink.confirmReceived,
        {"userOrderID": userOrderID, "userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  fetchOrders(String userID) async {
    var response = await crud.postData(AppLink.fetchOrders, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  cancelOrder(String userOrderID) async {
    var response =
        await crud.postData(AppLink.cancelOrder, {"userOrderID": userOrderID});
    return response.fold((l) => l, (r) => r);
  }

  buyAgain(orderitem, String userID) async {
    var response = await crud.postData(AppLink.buyAgain,
        {"userID": userID, "orderItem": jsonEncode(orderitem)});
    return response.fold((l) => l, (r) => r);
  }
}
