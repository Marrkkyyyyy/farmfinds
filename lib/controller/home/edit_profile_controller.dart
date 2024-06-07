import 'dart:io';

import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/update.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  UpdateUserData updateController = UpdateUserData(Get.find());
  final homeController = Get.find<HomeScreenController>();

  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();
  String? profile;
  String? userID;
  RxString fullName = "".obs;
  RxString phoneNumber = "".obs;
  RxString email = "".obs;
  File? image;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final currentTime = DateTime.now();
      final newName =
          'FarmFinds_${currentTime.hour}${currentTime.minute}${currentTime.second}${currentTime.millisecond}${currentTime.microsecond}_.jpg';
      final newPath = file.parent.path + '/' + newName;
      final renamedFile = await file.rename(newPath);
      final compressedFile = await compressFile(renamedFile);
      final compressedFileName = compressedFile.path;
      final newFileName = compressedFileName.replaceFirst('_compressed', '');
      final renamedCompressedFile = await compressedFile.rename(newFileName);
      image = File(renamedCompressedFile.path);
      update();
    }
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 15,
    );
    return compressedFile;
  }

  void userUpdateProfile() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading", dismissOnTap: true);
    var response = await updateController.updateUserProfile(image!, userID!);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.dismiss();
        await myServices.updateUserProfile(response['data']['userProfile']);
        Get.back(result: true);
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  void updateName() {
    fullName.value = myServices.getUser()!['fullName'];
    homeController.fullName.value = myServices.getUser()!['fullName'];
  }

  @override
  void onInit() {
    profile = myServices.getUser()?["userProfile"].toString();
    fullName.value = myServices.getUser()!["fullName"].toString();
    email.value = myServices.getUser()!["email"].toString();
    userID = myServices.getUser()?["userID"].toString();
    super.onInit();
  }
}
