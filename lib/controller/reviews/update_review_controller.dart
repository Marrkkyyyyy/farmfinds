import 'dart:io';

import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/data/model/new/review_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/class/status_request.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/reviews/review.dart';

class UpdateReviewController extends GetxController {
  ReviewData orderController = ReviewData(Get.find());
  MyServices myServices = Get.find();
  late ReviewModel reviews;
  late List<String> reviewImageUrl;
  late List<String> removeImageURL = [];
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  var size = Rx<Size>(Size.zero);
  final _imagePicker = ImagePicker();
  RxList<File?> selectedImages = <File?>[].obs;

  late RxInt rate = 0.obs;
  late TextEditingController feedbackController;

  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final currentTime = DateTime.now();
      final newName =
          'FarmFinds_Review_${currentTime.hour}${currentTime.minute}${currentTime.second}${currentTime.millisecond}${currentTime.microsecond}_.jpg';
      final newPath = file.parent.path + '/' + newName;
      final renamedFile = await file.rename(newPath);
      final compressedFile = await compressFile(renamedFile);
      final compressedFileName = compressedFile.path;
      final newFileName = compressedFileName.replaceFirst('_compressed', '');
      final renamedCompressedFile = await compressedFile.rename(newFileName);
      selectedImages.add(renamedCompressedFile);

      update();
    }
  }

  updateFeedback() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading", dismissOnTap: true);

    var response = await orderController.updateFeedback(
        reviews.orderID!,
        userID!,
        feedbackController.text,
        rate.value.toString(),
        selectedImages,
        removeImageURL);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Rating updated successfully");
        Future.delayed(Duration(milliseconds: 700), () {
          EasyLoading.dismiss();
          Get.back(result: true);
        });
      } else {
        showErrorMessage(response['message']);
      }
    } else if (StatusRequest.offlinefailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage("No internet connection");
    } else if (StatusRequest.serverfailure == statusRequest) {
      statusRequest = StatusRequest.none;
      showErrorMessage(
          "Server failure. Please check your internet connection and try again");
    }
    update();
  }

  Future<File> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 15,
    );
    return compressedFile;
  }

  @override
  void onInit() {
    userID = myServices.getUser()?["userID"].toString();
    reviews = Get.arguments['reviews'];
    if (reviews.reviewImageUrl != "null") {
      reviewImageUrl = reviews.reviewImageUrl!.split(',');
    } else {
      reviewImageUrl = [];
    }
    rate.value = int.parse(reviews.rating!);
    feedbackController = TextEditingController(text: reviews.comment);
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
