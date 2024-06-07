import 'dart:convert';

import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/address/address.dart';
import 'package:ecommerce/data/model/address_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ManipulateAddressController extends GetxController {
  AddressData addressController = AddressData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  late AddressModel address;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? userID;
  String? userAddressID;
  var size = Rx<Size>(Size.zero);
  List<String> code = [];
  List<String> provinces = [];
  List<String> municipal = [];
  List<String> barangay = [];
  String? selectedRegion;
  String? selectedRegionName;
  String? selectedProvince;
  String? selectedMunicipality;
  String? selectedBarangay;
  final Map<String, String> regionCodeData = {};
  late RxBool defaultAddress = false.obs;
  late String shopAddress;
  late RxString status = "".obs;
  late RxInt addressID = 0.obs;
  Map<String, dynamic>? addressData;
  late TextEditingController fullName, phoneNumber, postalCode, streetName;

  void clearData() {
    fullName.clear();
    phoneNumber.clear();
    postalCode.clear();
    streetName.clear();
    selectedRegion = null;
    selectedRegionName = null;
    selectedProvince = null;
    selectedMunicipality = null;
    selectedBarangay = null;
    update();
  }

  void addAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressController.addAddress(
        userID!,
        fullName.text,
        phoneNumber.text,
        selectedRegionName!,
        selectedProvince!,
        selectedMunicipality!,
        selectedBarangay!,
        postalCode.text,
        streetName.text,
        "0");

    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back(result: true);
      } else if (response['status'] == "successDefault") {
        final Map<String, dynamic> address = response['address'];
        await myServices.saveAddress(address);
        Get.back(result: true);
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else if (StatusRequest.offlinefailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    }
    update();
  }

  validateAddress() async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      if (shopAddress.isEmpty) {
        addAddress();
      } else {
        await myServices.savePickupData(
          fullName: fullName.text,
          phoneNumber: phoneNumber.text,
          selectedRegionName: selectedRegionName!,
          selectedProvince: selectedProvince!,
          selectedMunicipality: selectedMunicipality!,
          selectedBarangay: selectedBarangay!,
          postalCode: postalCode.text,
          streetName: streetName.text,
        );

        Get.back(result: true);
      }
    }
  }

  validateEditAddress() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      editAddress();
    }
  }

  void editAddress() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addressController.editAddress(
        userID!,
        addressID.value.toString(),
        fullName.text,
        phoneNumber.text,
        selectedRegionName!,
        selectedProvince!,
        selectedMunicipality!,
        selectedBarangay!,
        postalCode.text,
        streetName.text,
        defaultAddress.value);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        if (defaultAddress.value == false) {
          defaultAddress.value = false;
          Get.back(result: true);
        } else {
          await myServices.saveDefaultAddress(
            userAddressID: userAddressID!,
            status: defaultAddress.value == false ? "0" : "1",
            addressID: addressID.value,
            userID: userID!,
            fullName: fullName.text,
            phoneNumber: phoneNumber.text,
            selectedRegionName: selectedRegionName!,
            selectedProvince: selectedProvince!,
            selectedMunicipality: selectedMunicipality!,
            selectedBarangay: selectedBarangay!,
            postalCode: postalCode.text,
            streetName: streetName.text,
          );
          defaultAddress.value = false;
          Get.back(result: true);
        }
      } else {
        statusRequest = StatusRequest.failure;
      }
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    } else if (StatusRequest.offlinefailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    }
    update();
  }

  Future<void> loadAddressData() async {
    final String data = await rootBundle.loadString('assets/address.json');
    final jsonData = json.decode(data);
    addressData = jsonData;

    jsonData.forEach((regionCode, regionData) {
      var regionName = regionData['region_name'];
      regionCodeData[regionCode] = regionName;
      update();
    });
  }

  void selectRegion(String region) {
    selectedRegion = region;
    selectedRegionName = addressData![region]['region_name'];
    selectedProvince = null;
    selectedMunicipality = null;
    selectedBarangay = null;
    final selectedRegionData = addressData![region];
    final provinceList = selectedRegionData['province_list'];
    provinces = provinceList.keys.toList();

    update();
  }

  void selectProvince(String province) {
    selectedProvince = province;
    selectedMunicipality = null;
    selectedBarangay = null;

    final selectedRegionData = addressData![selectedRegion];
    final provinceList = selectedRegionData['province_list'];
    final municipalityData = provinceList[province];
    final municipalityList = municipalityData['municipality_list'];
    municipal = municipalityList.keys.toList();

    update();
  }

  void selectMunicipality(String municipality) {
    selectedMunicipality = municipality;
    selectedBarangay = null;

    final selectedRegionData = addressData![selectedRegion];
    final provinceList = selectedRegionData['province_list'];
    final municipalityData = provinceList[selectedProvince];
    final municipalityList = municipalityData['municipality_list'];
    final barangayData = municipalityList[municipality];
    barangay = List<String>.from(barangayData['barangay_list']);
    update();
  }

  @override
  void onInit() {
    loadAddressData();
    fullName = TextEditingController();
    phoneNumber = TextEditingController();
    postalCode = TextEditingController();
    streetName = TextEditingController();

    userID = myServices.getUser()?["userID"].toString();
    userAddressID = myServices.getAddress()?["userAddressID"].toString();
    shopAddress = Get.arguments?["shopAddress"] ?? "";
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    fullName.dispose();
    phoneNumber.dispose();
    postalCode.dispose();
    streetName.dispose();
    super.dispose();
  }
}
