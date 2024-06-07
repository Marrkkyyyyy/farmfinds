import 'dart:io';

import 'package:ecommerce/core/class/crud.dart';
import 'package:ecommerce/link_api.dart';

class UpdateUserData {
  Crud crud;
  UpdateUserData(this.crud);

  checkNumber(String phoneNumber) async {
    var response =
        await crud.postData(AppLink.checkNumber, {"phoneNumber": phoneNumber});

    return response.fold((l) => l, (r) => r);
  }

  updateUserProfile(File image, String userID) async {
    var response = await crud.postImageData(
        AppLink.updateUserProfile, {"image": image, "userID": userID});
    return response.fold((l) => l, (r) => r);
  }

  updateUserFullName(String userID, String fullName) async {
    var response = await crud.postData(
        AppLink.updateUserFullName, {"userID": userID, "fullName": fullName});

    return response.fold((l) => l, (r) => r);
  }

  sendVerificationCode(String email, String userID) async {
    var response = await crud.postData(AppLink.sendVerificationCode, {
      "email": email,
      "userID": userID,
    });

    return response.fold((l) => l, (r) => r);
  }

  verifyEmail(String userID, String verificationCode, String email) async {
    var response = await crud.postData(AppLink.verifyEmail,
        {"userID": userID, "verificationCode": verificationCode, "email": email});

    return response.fold((l) => l, (r) => r);
  }
}
