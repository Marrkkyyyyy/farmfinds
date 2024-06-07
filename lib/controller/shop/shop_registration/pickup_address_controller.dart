// import 'dart:convert';

// import 'package:ecommerce/controller/shop/shop_registration/shop_requirements_controller.dart';
// import 'package:ecommerce/core/services/services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';

// class PickupAddressController extends GetxController {
//   final shopRegistration = Get.find<ShopRequirementsController>();
//   MyServices myServices = Get.find();
//   GlobalKey<FormState> formstate = GlobalKey<FormState>();
//   String? userID;
//   var size = Rx<Size>(Size.zero);
//   List<String> code = [];
//   List<String> provinces = [];
//   List<String> municipal = [];
//   List<String> barangay = [];
//   String? selectedRegion;
//   String? selectedRegionName;
//   String? selectedProvince;
//   String? selectedMunicipality;
//   String? selectedBarangay;
//   final Map<String, String> regionCodeData = {};
//   Map<String, dynamic>? addressData;
//   late TextEditingController fullName, phoneNumber, postalCode, streetName;

//   void addPickupAddress() async {
//     myServices.savePickupData(
//       fullName: fullName.text,
//       phoneNumber: phoneNumber.text,
//       selectedRegionName: selectedRegionName!,
//       selectedProvince: selectedProvince!,
//       selectedMunicipality: selectedMunicipality!,
//       selectedBarangay: selectedBarangay!,
//       postalCode: postalCode.text,
//       streetName: streetName.text,
//     );

//     shopRegistration.pickupFullName.value =
//         myServices.getPickupData()?["fullName"];
//     shopRegistration.pickupPhoneNumber.value =
//         myServices.getPickupData()?["phoneNumber"];
//     shopRegistration.pickupRegion.value = myServices.getPickupData()?["region"];
//     shopRegistration.pickupProvince.value =
//         myServices.getPickupData()?["province"];
//     shopRegistration.pickupMunicipal.value =
//         myServices.getPickupData()?["municipal"];
//     shopRegistration.pickupBarangay.value =
//         myServices.getPickupData()?["barangay"];
//     shopRegistration.pickupPostalCode.value =
//         myServices.getPickupData()?["postalCode"];
//     shopRegistration.pickupStreetName.value =
//         myServices.getPickupData()?["streetName"];
//     Get.back();
//     update();
//   }

//   validateAddress() {
//     var formData = formstate.currentState;
//     if (formData!.validate()) {
//       addPickupAddress();
//     }
//   }

//   Future<void> loadAddressData() async {
//     final String data = await rootBundle.loadString('assets/address.json');
//     final jsonData = json.decode(data);
//     addressData = jsonData;

//     jsonData.forEach((regionCode, regionData) {
//       var regionName = regionData['region_name'];
//       regionCodeData[regionCode] = regionName;
//       update();
//     });
//   }

//   void selectRegion(String region) {
//     selectedRegion = region;
//     selectedRegionName = addressData![region]['region_name'];
//     selectedProvince = null;
//     selectedMunicipality = null;
//     selectedBarangay = null;
//     final selectedRegionData = addressData![region];
//     final provinceList = selectedRegionData['province_list'];
//     provinces = provinceList.keys.toList();

//     update();
//   }

//   void selectProvince(String province) {
//     selectedProvince = province;
//     selectedMunicipality = null;
//     selectedBarangay = null;

//     final selectedRegionData = addressData![selectedRegion];
//     final provinceList = selectedRegionData['province_list'];
//     final municipalityData = provinceList[province];
//     final municipalityList = municipalityData['municipality_list'];
//     municipal = municipalityList.keys.toList();

//     update();
//   }

//   void selectMunicipality(String municipality) {
//     selectedMunicipality = municipality;
//     selectedBarangay = null;

//     final selectedRegionData = addressData![selectedRegion];
//     final provinceList = selectedRegionData['province_list'];
//     final municipalityData = provinceList[selectedProvince];
//     final municipalityList = municipalityData['municipality_list'];
//     final barangayData = municipalityList[municipality];
//     barangay = List<String>.from(barangayData['barangay_list']);
//     update();
//   }

//   @override
//   void onInit() {
//     loadAddressData();
//     fullName = TextEditingController();
//     phoneNumber = TextEditingController();
//     postalCode = TextEditingController();
//     streetName = TextEditingController();
//     userID = myServices.getUser()?["userID"].toString();
//     size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
//     super.onInit();
//   }

//   @override
//   void dispose() {
//     fullName.dispose();
//     phoneNumber.dispose();
//     postalCode.dispose();
//     streetName.dispose();
//     super.dispose();
//   }
// }
