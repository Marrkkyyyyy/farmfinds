import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/address/address.dart';
import 'package:ecommerce/data/model/address_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddressSelectionController extends GetxController {
  AddressData addressController = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  String? userID;
  RxInt addressID = 0.obs;
  var size = Rx<Size>(Size.zero);
  RxList<AddressModel> addresses = RxList<AddressModel>([]);
  Rx<AddressModel?> selectedAddress = Rx<AddressModel?>(null);

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
        AddressModel? initialAddress = addresses.firstWhere(
          (address) => address.addressID == addressID.value.toString(),
        );
        selectedAddress.value = initialAddress;
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<bool> selectDefaultAddress(String userAddressID) async {
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response =
        await addressController.selectDefaultAddress(userID!, userAddressID);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest &&
        response['status'] == "success") {
      EasyLoading.dismiss();
      return true;
    } else if (statusRequest == StatusRequest.offlinefailure) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
      return false;
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
      return false;
    } else {
      EasyLoading.dismiss();
      return false;
    }
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    addressID.value = Get.arguments?['addressID'];
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    fetchAddress();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
