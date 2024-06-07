import 'dart:io';

import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/data/datasource/remote/scanner/vegetable.dart';
import 'package:ecommerce/data/model/search_vegetable_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ScannerController extends GetxController {
  Vegetable vegetableData = Vegetable(Get.find());
  RxBool isInternet = false.obs;

  checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return isInternet.value = true;
      }
    } on SocketException catch (_) {
      return isInternet.value = false;
    }
  }

  var size = Rx<Size>(Size.zero);
  StatusRequest statusRequest = StatusRequest.none;
  @override
  void onInit() {
    super.onInit();
    loadModel();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      classifyImage(imagePath);
    }
  }

  Future<void> camera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final imagePath = pickedFile.path;
      classifyImage(imagePath);
    }
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite',
        labels: 'assets/labels.txt',
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  Future<void> classifyImage(String imagePath) async {
    if (await checkInternet()) {
      var detector = await Tflite.runModelOnImage(
          path: imagePath,
          imageMean: 0.0,
          imageStd: 255.0,
          numResults: 1,
          threshold: 0.2,
          asynch: true);

      if (detector != null && detector.isNotEmpty) {
        var recognition = detector[0];

        String label = recognition['label'];

        if (recognition['confidence'] > 0.3) {
          statusRequest = StatusRequest.none;
          update();

          Get.toNamed(AppRoute.scannedVegetable, arguments: {'label': label});
        } else {
          statusRequest = StatusRequest.loading;
          update();
          Future.delayed(const Duration(seconds: 1), () {
            statusRequest = StatusRequest.noSearchFound;
            update();
          });
        }
      }
    } else {
      statusRequest = StatusRequest.offlinefailure;
      update();
    }
  }

  @override
  void dispose() {
    disposeTfltte();
    super.dispose();
  }

  disposeTfltte() async {
    await Tflite.close();
  }

  final searchData = RxList<dynamic>();
  searchVegetable({required String englishName}) async {
    try {
      var response = await vegetableData.getSearchData(englishName);

      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          searchData.assignAll(response['data'] as List);
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
    }
  }

  var data = [];
  List<SearchVegetableModel> results = [];
  List<String> imageUrls = [];

  Future<List<SearchVegetableModel>> getVegetableSearch({String? query}) async {
    var response = await vegetableData.getSearchData(query!);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        data = response['data'];
        results = data.map((e) => SearchVegetableModel.fromJson(e)).toList();
        results = results
            .where((element) =>
                element.englishName!
                    .toLowerCase()
                    .contains((query.toLowerCase())) ||
                element.tagalogName!
                    .toLowerCase()
                    .contains((query.toLowerCase())))
            .toList();
        imageUrls = data[0]['imageURLs'].split(',');
      } else {
        results = [];
        statusRequest = StatusRequest.failure;
      }
    }
    return results;
  }
}
