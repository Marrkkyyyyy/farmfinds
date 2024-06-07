import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    await Firebase.initializeApp();
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveDefaultAddress({
    required String userAddressID,
    required String status,
    required int addressID,
    required String userID,
    required String fullName,
    required String phoneNumber,
    required String selectedRegionName,
    required String selectedProvince,
    required String selectedMunicipality,
    required String selectedBarangay,
    required String postalCode,
    required String streetName,
  }) async {
    final Map<String, dynamic> addressMap = {
      'userAddressID': userAddressID,
      'status': status,
      'addressID': addressID,
      'userID': userID,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'region': selectedRegionName,
      'province': selectedProvince,
      'city': selectedMunicipality,
      'barangay': selectedBarangay,
      'postalCode': postalCode,
      'streetName': streetName,
    };

    final String addressJson = json.encode(addressMap);
    await sharedPreferences.setString('addressData', addressJson);
  }

  Future<void> clearPreferences() async {
    await sharedPreferences.clear();
  }

  Future<void> saveUserData(Map<String, dynamic> addressData,
      Map<String, dynamic> userData, Map<String, dynamic> shopData) async {
    await saveAddress(addressData);
    await saveUser(userData);
    await saveShop(shopData);
  }

  Future<void> saveAddress(Map<String, dynamic> addressData) async {
    final String addressJson = json.encode(addressData);
    await sharedPreferences.setString('addressData', addressJson);
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    final String userJson = json.encode(userData);
    await sharedPreferences.setString('userData', userJson);
  }

  Future<void> updateUserFullName(String newFullName) async {
    Map<String, dynamic>? userData = getUser();

    if (userData != null) {
      userData['fullName'] = newFullName;
      await saveUser(userData);
    }
  }

  Future<void> updateUserEmail(String email) async {
    Map<String, dynamic>? userData = getUser();

    if (userData != null) {
      userData['email'] = email;
      await saveUser(userData);
    }
  }

  Future<void> updateUserProfile(String newProfile) async {
    Map<String, dynamic>? userData = getUser();

    if (userData != null) {
      userData['userProfile'] = newProfile;
      await saveUser(userData);
    }
  }

  Future<void> saveShop(Map<String, dynamic> shopData) async {
    final String shopJson = json.encode(shopData);
    await sharedPreferences.setString('shopData', shopJson);
  }

  Future<void> savePickupData({
    required String fullName,
    required String phoneNumber,
    required String selectedRegionName,
    required String selectedProvince,
    required String selectedMunicipality,
    required String selectedBarangay,
    required String postalCode,
    required String streetName,
  }) async {
    final Map<String, dynamic> pickupData = {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "region": selectedRegionName,
      "province": selectedProvince,
      "city": selectedMunicipality,
      "barangay": selectedBarangay,
      "postalCode": postalCode,
      "streetName": streetName,
    };

    final String pickupDataJson = json.encode(pickupData);
    await sharedPreferences.setString('pickupData', pickupDataJson);
  }

  Future<void> saveShopRegisteredData({
    required int shopID,
    required int pickupAddressID,
    required String shopName,
    required String profile,
  }) async {
    final Map<String, dynamic> shopRegisteredData = {
      "shopID": shopID,
      "pickupAddressID": pickupAddressID,
      "shopName": shopName,
      "profile": profile,
    };

    final String shopRegisteredDataJson = json.encode(shopRegisteredData);
    await sharedPreferences.setString('shopData', shopRegisteredDataJson);
  }

  Map<String, dynamic>? getAddress() {
    final String? addressJson = sharedPreferences.getString('addressData');
    if (addressJson != null) {
      return json.decode(addressJson);
    }
    return null;
  }

  Map<String, dynamic>? getUser() {
    final String? userJson = sharedPreferences.getString('userData');
    if (userJson != null) {
      return json.decode(userJson);
    }
    return null;
  }

  Map<String, dynamic>? getShop() {
    final String? shopJson = sharedPreferences.getString('shopData');
    if (shopJson != null) {
      return json.decode(shopJson);
    }
    return null;
  }

  Map<String, dynamic>? getShopRegisteredData() {
    final String? shopJson = sharedPreferences.getString('shopRegisteredData');
    if (shopJson != null) {
      return json.decode(shopJson);
    }
    return null;
  }

  Map<String, dynamic>? getPickupData() {
    final String? pickupJson = sharedPreferences.getString('pickupData');
    if (pickupJson != null) {
      return json.decode(pickupJson);
    }
    return null;
  }

  String? getUserName() {
    return getAddress()!['fullName'];
  }
}

initialServices() async {
  await Get.putAsync(() {
    return MyServices().init();
  });
}
