import 'dart:io';

import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/class/status_request.dart';
import '../../core/functions/handling_data_controller.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/reviews/review.dart';

class ReviewController extends GetxController {
  ReviewData orderController = ReviewData(Get.find());
  MyServices myServices = Get.find();
  late OrderItemModels orderItems;
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  var size = Rx<Size>(Size.zero);
  final _imagePicker = ImagePicker();
  RxList<File?> selectedImages = <File?>[].obs;
  late RxInt rate = 0.obs;
  late TextEditingController feedbackController;
  late List<String> productIDs = [];
  late List<String> variationIDs = [];
  late List<String> productImageUrls = [];

  void getProductIDs() {
    for (var item in orderItems.order) {
      productIDs.add(item.productID!);
    }
  }

  void getVariationIDs() {
    for (var item in orderItems.order) {
      variationIDs.add(item.productVariationID!);
    }
  }

  void getPoductImageUrls() {
    for (var item in orderItems.order) {
      productImageUrls.add(item.productImageURL!);
    }
  }

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

  validateFeedback() {
    if (rate.value == 0) {
      showErrorMessage("Please provide a star rating to submit your feedback.");
    } else {
      submitFeedback();
    }
  }

  submitFeedback() async {
    statusRequest = StatusRequest.loading;
    update();
    EasyLoading.show(status: "Loading", dismissOnTap: true);

    var response = await orderController.submitFeedback(
        orderItems.userOrderID!,
        userID!,
        productIDs.toList(),
        variationIDs.toList(),
        productImageUrls.toList(),
        rate.value.toString(),
        feedbackController.text,
        selectedImages);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Rating submitted successfully");
        Future.delayed(Duration(milliseconds: 700), () {
          EasyLoading.dismiss();
          Get.offAllNamed(AppRoute.home);
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
    orderItems = Get.arguments['orderItems'];
    getProductIDs();
    getVariationIDs();
    getPoductImageUrls();
    feedbackController = TextEditingController();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
