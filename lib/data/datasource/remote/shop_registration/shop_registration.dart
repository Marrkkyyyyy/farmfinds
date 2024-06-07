import 'dart:io';

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class ShopRegistrationData {
  Crud crud;
  ShopRegistrationData(this.crud);

  checkEmail(String email) async {
    var response = await crud.postData(AppLink.checkEmail, {"email": email});
    return response.fold((l) => l, (r) => r);
  }

  emailBind(String email, String userID) async {
    var response = await crud
        .postData(AppLink.emailBind, {"email": email, "userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  registerShop(
      File image,
      String userID,
      String fullName,
      String phoneNumber,
      String region,
      String province,
      String city,
      String barangay,
      String postalCode,
      String streetName,
      String shopName) async {
    var response = await crud.postImageData(AppLink.registerShop, {
      "image": image,
      "userID": userID,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "region": region,
      "province": province,
      "city": city,
      "barangay": barangay,
      "postalCode": postalCode,
      "streetName": streetName,
      "shopName": shopName
    });
    return response.fold((l) => l, (r) => r);
  }

  checkNumber(String phoneNumber) async {
    var response =
        await crud.postData(AppLink.checkNumber, {"phoneNumber": phoneNumber});

    return response.fold((l) => l, (r) => r);
  }

  phoneBind(String phoneNumber, String userID) async {
    var response = await crud.postData(
        AppLink.phoneBind, {"phoneNumber": phoneNumber, "userID": userID});
    return response.fold((l) => l, (r) => r);
  }
}
