import 'dart:io';

import 'package:ecommerce/controller/shop/product/variation_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/product/product.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  ProductData productController = ProductData(Get.find());
  final variationController = Get.put(VariationController());
  MyServices myServices = Get.find();
  String? shopID;
  String? userID;
  StatusRequest statusRequest = StatusRequest.none;
  late TextEditingController productName, productDescription, price;
  var size = Rx<Size>(Size.zero);
  GlobalKey<FormState> nameFormstate = GlobalKey<FormState>();
  GlobalKey<FormState> descriptionFormstate = GlobalKey<FormState>();
  late BuildContext context;

  final _imagePicker = ImagePicker();
  RxList<File?> selectedImages = <File?>[].obs;
  RxInt nameCharacterCount = 0.obs;
  RxInt descriptionCharacterCount = 0.obs;

  addProduct() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await productController.addProduct(
        userID!,
        shopID!,
        productName.text,
        productDescription.text,
        price.text,
        selectedImages,
        variationController.variationList);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        showSuccessMessage("Product successfully added");
        resetData();
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

  resetData() {
    selectedImages.clear();
    productName.text = "";
    productDescription.text = "";
    price.text = "";
    variationController.variationList.clear();
    variationController.selectedVariation.clear();
    variationController.variationPrice.clear();
    nameCharacterCount.value = 0;
    descriptionCharacterCount.value = 0;
    update();
  }

  void updateCharacterCount() {
    nameCharacterCount.value = productName.text.trim().length;
    descriptionCharacterCount.value = productDescription.text.length;
    update();
  }

  productValidate() {
    var formData = nameFormstate.currentState;
    var formData1 = descriptionFormstate.currentState;
    if (formData!.validate() && formData1!.validate()) {
      if (selectedImages.isEmpty) {
        showErrorMessage(
            "No images selected. Please select at least one image");
      } else if (price.text.isEmpty) {
        showErrorMessage("Price is required");
      } else {
        addProduct();
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

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

      selectedImages.add(renamedCompressedFile);

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

  @override
  void onInit() {
    context = Get.context!;
    productName = TextEditingController();
    productDescription = TextEditingController();
    price = TextEditingController();

    int? shopIDInt = myServices.getShop()?["shopID"];
    shopID = shopIDInt?.toString() ?? "";
    userID = myServices.getUser()?["userID"].toString();
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    productName.dispose();
    productDescription.dispose();
    price.dispose();
    super.dispose();
  }
}
