import 'dart:convert';

import 'package:ecommerce/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class EditPickupAddressController extends GetxController {
  MyServices myServices = Get.find();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  String? userID;
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
  Map<String, dynamic>? addressData;
  late TextEditingController fullName, phoneNumber, postalCode, streetName;

  void addPickupAddress() async {
    myServices.sharedPreferences.setString("pickupFullName", fullName.text);
    myServices.sharedPreferences
        .setString("pickupPhoneNumber", phoneNumber.text);
    myServices.sharedPreferences.setString("pickupRegion", selectedRegionName!);
    myServices.sharedPreferences.setString("pickupProvince", selectedProvince!);
    myServices.sharedPreferences
        .setString("pickupMunicipal", selectedMunicipality!);
    myServices.sharedPreferences.setString("pickupBarangay", selectedBarangay!);
    myServices.sharedPreferences.setString("pickupPostalCode", postalCode.text);
    myServices.sharedPreferences.setString("pickupStreetName", streetName.text);

    Get.back();
    update();
  }

  validateAddress() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      addPickupAddress();
    }
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
    userID = myServices.sharedPreferences.getString("id");
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    // fullName.text = myServices.sharedPreferences.getString("pickupFullName")!;
    // phoneNumber.text =
    //     myServices.sharedPreferences.getString("pickupPhoneNumber")!;
    // selectedRegionName =
    //     myServices.sharedPreferences.getString("pickupRegion")!;
    // selectedProvince =
    //     myServices.sharedPreferences.getString("pickupProvince")!;
    // selectedMunicipality =
    //     myServices.sharedPreferences.getString("pickupMunicipal")!;
    // selectedBarangay =
    //     myServices.sharedPreferences.getString("pickupBarangay")!;
    // postalCode.text =
    //     myServices.sharedPreferences.getString("pickupPostalCode")!;
    // streetName.text =
    //     myServices.sharedPreferences.getString("pickupStreetName")!;

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
