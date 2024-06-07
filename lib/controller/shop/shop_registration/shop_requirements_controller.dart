import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/home_screen_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/shop_registration/shop_registration.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ShopRequirementsController extends GetxController {
  ShopRegistrationData shopController = ShopRegistrationData(Get.find());
  HomeScreenController homeController = Get.find();

  late TextEditingController shopName, bindPhoneNumber;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> formstateBind = GlobalKey<FormState>();
  RxBool isVerified = false.obs;
  String phoneVerified = "";
  final _auth = FirebaseAuth.instance;
  var verificationId = '';
  RxInt shopCharacterCount = 0.obs;
  String userEmail = '';
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  String? userID;
  String? email;
  String? phoneNumber;
  String? pickupAddressID;
  String otp = '';
  var size = Rx<Size>(Size.zero);
  RxString pickupFullName = ''.obs;
  RxString pickupPhoneNumber = ''.obs;
  RxString pickupRegion = ''.obs;
  RxString pickupProvince = ''.obs;
  RxString pickupMunicipal = ''.obs;
  RxString pickupBarangay = ''.obs;
  RxString pickupPostalCode = ''.obs;
  RxString pickupStreetName = ''.obs;
  late BuildContext contexts;
  File? image;

  // used after validate
  late String validPhoneNumber;
  bool isValidPhoneNumber = false;

  void convertPhoneNumber() {
    String currentText = bindPhoneNumber.text;
    if (currentText.startsWith("09")) {
      bindPhoneNumber.text = "(+63) 9" + currentText.substring(2);
      validPhoneNumber = "+639" + currentText.substring(2);
    } else if (currentText.startsWith("+639")) {
      bindPhoneNumber.text = "(+63) 9" + currentText.substring(4);
      validPhoneNumber = "+639" + currentText.substring(4);
    } else if (currentText.startsWith("(+63) 9")) {
      validPhoneNumber = "+639" + currentText.substring(7);
    }
    isValidPhoneNumber = true;
  }

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

  validateShop(context) {
    var formData = formstate.currentState;
    if (formData!.validate() &&
        shopName.text.isNotEmpty &&
        pickupRegion.value != "" &&
        phoneNumber != "" &&
        phoneNumber != "null" &&
        email != "" &&
        email != "null") {
      if (image != null) {
        shopRegistration(context);
      } else {
        showErrorMessage("Please choose an image for your shop");
      }
    } else {
      showErrorMessage("Please complete required field");
    }
  }

  validatePhoneBind() {
    var formData = formstateBind.currentState;
    if (formData!.validate()) {
      if (!isValidPhoneNumber) {
        convertPhoneNumber();
      } else {
        checkNumber();
      }
    } else {
      isValidPhoneNumber = false;
    }
  }

  checkNumber() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopController.checkNumber(validPhoneNumber);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        phoneAuthentication(validPhoneNumber);
        Get.toNamed(AppRoute.otpBind, arguments: {
          'phoneNumber': validPhoneNumber,
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
        showErrorMessage("Something went wrong. Try again later", seconds: 5);
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
        isVerified.value = true;
        update();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
        update();
      },
    );
  }

  verifyOTP(String otp, String phoneNumber) async {
    phoneVerify(otp, phoneNumber);
  }

  phoneVerify(String otp, String phoneNumber) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      if (credentials.user != null) {
        phoneVerified = phoneNumber;
        update();
        phoneBind();
      } else {
        showErrorMessage("Something went wrong. Please try again");
      }
    } catch (e) {
      showErrorMessage(
          "Please check and enter the correct verification code again");
    }
  }

  phoneBind() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopController.phoneBind(phoneVerified, userID!);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        isVerified.value = false;
        phoneNumber = phoneVerified;
        myServices.sharedPreferences.setString("phoneNumber", phoneVerified);
        update();
        Get.back();
        Get.back();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  void shopRegistration(context) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopController.registerShop(
        image!,
        userID!,
        pickupFullName.value,
        pickupPhoneNumber.value,
        pickupRegion.value,
        capitalizeEachWord(pickupProvince.value),
        capitalizeEachWord(pickupMunicipal.value),
        capitalizeEachWord(pickupBarangay.value),
        pickupPostalCode.value,
        pickupStreetName.value,
        shopName.text);
    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        pickupAddressID = response['data']['pickupAddressID'].toString();
        homeController.shopID.value = response['data']['shopID'].toString();
        homeController.update();
        precacheImage(
            CachedNetworkImageProvider(
                "${AppLink.shopImage}${response['data']['profile']}"),
            contexts);
        AwesomeDialog(
                dismissOnTouchOutside: false,
                btnOkText: "Okay",
                buttonsTextStyle: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
                dismissOnBackKeyPress: false,
                headerAnimationLoop: false,
                btnOkOnPress: () async {
                  removePickupAddress();
                  await myServices.saveShopRegisteredData(
                      shopID: response['data']['shopID'],
                      pickupAddressID: response['data']['pickupAddressID'],
                      shopName: response['data']['shopName'],
                      profile: response['data']['profile']);

                  Get.offNamed(AppRoute.shop);
                },
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'You shop has been successfully registered',
                titleTextStyle: Theme.of(context).textTheme.headline5)
            .show();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  void removePickupAddress() async {
    await myServices.sharedPreferences.remove('pickupData');
  }

  String capitalizeEachWord(String input) {
    if (input.isEmpty) {
      return input;
    }

    final words = input.split(' ');
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    });

    return capitalizedWords.join(' ');
  }

  void updateCharacterCount() {
    shopCharacterCount.value = shopName.text.length;
  }

  void emailBind() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await shopController.emailBind(userEmail, userID!);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        EasyLoading.showSuccess("Successfully Bind",
            dismissOnTap: true,
            duration: const Duration(seconds: 1, milliseconds: 500));
        myServices.sharedPreferences
            .setString("email", response['data']['email'].toString());
        email = myServices.sharedPreferences.getString("email");
        update();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  void google() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final userEmail = googleUser.email;
        this.userEmail = userEmail;
        statusRequest = StatusRequest.loading;
        update();
        var response = await shopController.checkEmail(userEmail);

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            emailBind();
          } else {
            showErrorMessage(response['message']);
          }
        }
        update();
      } else {
        throw showErrorMessage("Google bind failed");
      }
    } catch (e) {
      throw showErrorMessage("Google bind failed");
    }
  }

  initialData() {
    userID = myServices.getUser()?["userID"].toString();
    email = myServices.getUser()?["email"];
    phoneNumber = myServices.getUser()?["phoneNumber"].toString();

    pickupFullName.value = myServices.getPickupData()?["fullName"] ?? "";
    pickupPhoneNumber.value = myServices.getPickupData()?["phoneNumber"] ?? "";
    pickupRegion.value = myServices.getPickupData()?["region"] ?? "";
    pickupProvince.value = myServices.getPickupData()?["province"] ?? "";
    pickupMunicipal.value = myServices.getPickupData()?["city"] ?? "";
    pickupBarangay.value = myServices.getPickupData()?["barangay"] ?? "";
    pickupPostalCode.value = myServices.getPickupData()?["postalCode"] ?? "";
    pickupStreetName.value = myServices.getPickupData()?["streetName"] ?? "";
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  @override
  void onInit() {
    contexts = Get.context!;
    shopName = TextEditingController();
    bindPhoneNumber = TextEditingController();
    initialData();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    shopName.dispose();
    bindPhoneNumber.dispose();
  }
}
