import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/address/address.dart';
import 'package:ecommerce/data/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  AddressData addressController = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  String? userID;
  var size = Rx<Size>(Size.zero);
  late RxBool defaultAddress = false.obs;
  RxList<AddressModel> addresses = RxList<AddressModel>([]);

  Future<void> refreshData() async {
    await fetchAddress();
  }

  fetchAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressController.fetchAddress(userID!);

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        List<dynamic> addressList = response['address'];

        addresses.assignAll(
            addressList.map((shopData) => AddressModel.fromJson(shopData)));
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    fetchAddress();
    super.onInit();
  }
}
