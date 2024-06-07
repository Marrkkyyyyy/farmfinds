import 'dart:convert';

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class CartData {
  Crud crud;
  CartData(this.crud);

  deleteCart(String cartID) async {
    var response = await crud.postData(AppLink.deleteCart, {
      "cartID": cartID,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateQuantity(String cartID, String quantity) async {
    var response = await crud.postData(AppLink.updateQuantity, {
      "quantity": quantity,
      "cartID": cartID,
    });
    return response.fold((l) => l, (r) => r);
  }

  addToCart(String userID, String productID, String productVariationID,
      String quantity) async {
    var response = await crud.postData(AppLink.addToCart, {
      "userID": userID,
      "productID": productID,
      "productVariationID": productVariationID,
      "quantity": quantity
    });

    return response.fold((l) => l, (r) => r);
  }

  fetchCart(String userID) async {
    var response = await crud.postData(AppLink.fetchCart, {"userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  addAddress(
    String userID,
    String fullName,
    String phoneNumber,
    String region,
    String province,
    String city,
    String barangay,
    String postalCode,
    String streetName,
    String addressStatus,
  ) async {
    var response = await crud.postData(AppLink.addAddress, {
      "userID": userID,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "region": region,
      "province": province,
      "city": city,
      "barangay": barangay,
      "postalCode": postalCode,
      "streetName": streetName,
      "addressStatus": addressStatus
    });
    return response.fold((l) => l, (r) => r);
  }

  placeOrder(
      orderItem, String userID, int addressID, String shippingFee) async {
    var response = await crud.postData(AppLink.placeOrder, {
      "orderItem": jsonEncode(orderItem),
      "userID": userID,
      "shippingAddressID": addressID.toString(),
      "shippingFee": shippingFee
    });
    return response.fold((l) => l, (r) => r);
  }
}
