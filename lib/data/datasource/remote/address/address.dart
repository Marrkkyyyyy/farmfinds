import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class AddressData {
  Crud crud;
  AddressData(this.crud);

  addAddress(
    String userID,
    String fullName,
    String phoneNumber,
    String region,
    String province,
    String city,
    String barangay,
    String postalCode,
    String streetName,
    String addressStatus,
  ) async {
    var response = await crud.postData(AppLink.addAddress, {
      "userID": userID,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "region": region,
      "province": province,
      "city": city,
      "barangay": barangay,
      "postalCode": postalCode,
      "streetName": streetName,
      "addressStatus": addressStatus
    });
    return response.fold((l) => l, (r) => r);
  }

  editAddress(
    String userID,
    String addressID,
    String fullName,
    String phoneNumber,
    String region,
    String province,
    String city,
    String barangay,
    String postalCode,
    String streetName,
    bool addressStatus,
  ) async {
    var response = await crud.postData(AppLink.editAddress, {
      "userID": userID,
      "addressID": addressID,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "region": region,
      "province": province,
      "city": city,
      "barangay": barangay,
      "postalCode": postalCode,
      "streetName": streetName,
      "addressStatus": addressStatus.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  selectDefaultAddress(
    String userID,
    String userAddressID,
  ) async {
    var response = await crud.postData(AppLink.selectDefaultAddress, {
      "userID": userID,
      "userAddressID": userAddressID,
    });
    return response.fold((l) => l, (r) => r);
  }

  fetchAddress(String userID) async {
    var response = await crud.postData(AppLink.fetchAddress, {
      "userID": userID,
    });
    return response.fold((l) => l, (r) => r);
  }
}
