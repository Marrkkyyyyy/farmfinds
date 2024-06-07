import 'package:ecommerce/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchVegetableController extends GetxController {
  var size = Rx<Size>(Size.zero);
  var imageURLs = RxList<String>();
  StatusRequest statusRequest = StatusRequest.none;
  final RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }
}
