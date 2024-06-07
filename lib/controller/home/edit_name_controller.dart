import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/update.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {
  UpdateUserData updateController = UpdateUserData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  late TextEditingController fullNameController;
  String? userID;
  String? textFieldName;
  RxBool onSave = false.obs;
  var size = Rx<Size>(Size.zero);
  GlobalKey<FormState> formSate = GlobalKey<FormState>();

  Validate() {
    var formData = formSate.currentState;
    if (formData!.validate()) {
      updateUserFullName();
    }
  }

  void updateUserFullName() async {
    statusRequest = StatusRequest.loading;
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    update();
    var response = await updateController.updateUserFullName(
        userID!, fullNameController.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        await myServices.updateUserFullName(fullNameController.text);

        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  @override
  void onInit() {
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    userID = myServices.getUser()?["userID"].toString();
    textFieldName = Get.arguments['fullName'];
    fullNameController = TextEditingController(text: textFieldName);
    super.onInit();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }
}
