import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/data/model/vegetable_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasource/remote/scanner/vegetable.dart';

class ScannedProfileController extends GetxController {
  Vegetable vegetableData = Vegetable(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  List<VegetableModel> data = [];
  final RxInt currentIndex = 0.obs;
  var size = Rx<Size>(Size.zero);
  late String? englishName;
  List<String> imageUrls = [];
  List<String> searchImageUrls = [];
  @override
  void onInit() {
    englishName = Get.arguments['label'];
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    getData();
    super.onInit();
  }

  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await vegetableData.getData(englishName!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        VegetableModel vegetableModel =
            VegetableModel.fromJson(response['data']);
        data.add(vegetableModel);
        imageUrls = data[0].imageURLs!.split(',');
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
