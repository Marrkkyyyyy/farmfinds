import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/update.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UpdateEmailController extends GetxController {
  UpdateUserData updateController = UpdateUserData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  String? userID;
  late TextEditingController emailController;
  RxBool isEmail = false.obs;
  RxBool isSent = false.obs;
  var size = Rx<Size>(Size.zero);
  GlobalKey<FormState> formSate = GlobalKey<FormState>();

  Validate() {
    var formData = formSate.currentState;
    if (formData!.validate()) {
      sendVerificationCode();
    }
  }

  void sendVerificationCode() async {
    statusRequest = StatusRequest.loading;
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    update();
    var response = await updateController.sendVerificationCode(
        emailController.text, userID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        Get.toNamed(AppRoute.changeEmailOTP);
        isSent.value = true;
      } else {
        showErrorMessage(response['message']);
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage(
          "Please check your internet connection and refresh the page");
    } else {
      EasyLoading.dismiss();
      showErrorMessage("Something went wrong. Please try again later");
    }
    update();
  }

  verifyEmail(String code) async {
    statusRequest = StatusRequest.loading;
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    update();
    var response =
        await updateController.verifyEmail(userID!, code, emailController.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Successfully Updated");
        await myServices.updateUserEmail(emailController.text);
        Future.delayed(Duration(seconds: 1), () {
          Get.offAllNamed(AppRoute.home);
        });
      } else {
        showErrorMessage(response['message']);
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      EasyLoading.dismiss();
      showErrorMessage(
          "Please check your internet connection and refresh the page");
    } else {
      EasyLoading.dismiss();
      showErrorMessage("Something went wrong. Please try again later");
    }
    update();
  }

  @override
  void onInit() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    userID = myServices.getUser()?["userID"].toString();
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
