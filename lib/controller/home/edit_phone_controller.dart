import 'package:ecommerce/controller/home/edit_profile_controller.dart';
import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/update.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserPhoneController extends GetxController {
  UpdateUserData updateController = UpdateUserData(Get.find());
  final controller = Get.find<EditProfileController>();
  final homeController = Get.find<HomeScreenController>();
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  late TextEditingController phoneNumberController;
  String? userID;
  String? phoneNumber;
  var size = Rx<Size>(Size.zero);
  GlobalKey<FormState> formSate = GlobalKey<FormState>();
  bool isValidPhoneNumber = false;
  late String validPhoneNumber;
  final _auth = FirebaseAuth.instance;
  RxBool isVerified = false.obs;
  String phoneVerified = "";
  var verificationId = '';
  late RxBool onSave = false.obs;
  String otp = '';
  updatePhone() {
    var formDataPhone = formSate.currentState;
    if (formDataPhone!.validate()) {
      if (!isValidPhoneNumber) {
        convertPhoneNumber();
      } else {
        checkNumber();
      }
    } else {
      isValidPhoneNumber = false;
    }
  }

  void convertPhoneNumber() {
    String currentText = phoneNumberController.text;
    if (currentText.startsWith("09")) {
      phoneNumberController.text = "(+63) 9" + currentText.substring(2);
      validPhoneNumber = "+639" + currentText.substring(2);
    } else if (currentText.startsWith("+639")) {
      phoneNumberController.text = "(+63) 9" + currentText.substring(4);
      validPhoneNumber = "+639" + currentText.substring(4);
    } else if (currentText.startsWith("(+63) 9")) {
      validPhoneNumber = "+639" + currentText.substring(7);
    }
    isValidPhoneNumber = true;
  }

  checkNumber() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await updateController.checkNumber(validPhoneNumber);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        phoneAuthentication(validPhoneNumber);
        Get.toNamed(AppRoute.otpUpdate, arguments: {
          'phoneNumber': validPhoneNumber,
          'auth': "signIn",
        });
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showErrorMessage("Something went wrong. Try again later", seconds: 8);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
        isVerified.value = true;
        phoneVerified = phoneNo;
        update();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
        update();
      },
    );
  }

  phoneUpdate(String otp, String phoneNumber) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      if (credentials.user != null) {
        // updateData();
      } else {
        showErrorMessage("Something went wrong. Please Try again");
      }
    } catch (e) {
      showErrorMessage(
          "Please check and enter the correct verification code again.");
    }
  }

  // updateData() async {
  //   statusRequest = StatusRequest.loading;
  //   update();
  //   var response = await loginController.phoneSignin(phoneVerified);

  //   statusRequest = handlingData(response);

  //   if (StatusRequest.success == statusRequest) {
  //     if (response['status'] == "success") {
  //       isVerified.value = false;
  //       update();
  //     } else {
  //       showErrorMessage(response['message']);
  //     }
  //   }
  //   update();
  // }

  @override
  void onInit() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    userID = myServices.getUser()?["userID"].toString();
    phoneNumber = Get.arguments['phoneNumber'];
    phoneNumberController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}
