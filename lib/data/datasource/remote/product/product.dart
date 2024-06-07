import 'dart:convert';
import 'dart:io';
import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';
import 'package:get/get.dart';

class ProductData {
  Crud crud;
  ProductData(this.crud);

  fetchVariation() async {
    var response = await crud.postData(AppLink.fetchVariation, {});
    return response.fold((l) => l, (r) => r);
  }

  addProduct(
      String userID,
      String shopID,
      String productName,
      String productDescription,
      String price,
      RxList<File?> selectedImages,
      List<Map<String, dynamic>> variation) async {
    var response = await crud.postImageData(AppLink.addProduct, {
      'userID': userID,
      'shopID': shopID,
      'productName': productName,
      'productDescription': productDescription,
      'price': price,
      'image': selectedImages,
      'variation': json.encode(variation),
    });

    return response.fold((l) => l, (r) => r);
  }
}
