import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/login.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginController extends GetxController {
  loginValidate();
  loginPhone();
  goToSignUp();
  goToOTP();
  goToHome();
  goToLoginPhone(bool arguments);
}

class LoginControllerImp extends LoginController {
  LoginData loginController = LoginData(Get.find());
  MyServices myServices = Get.find();

  final _auth = FirebaseAuth.instance;
  var verificationId = '';
  RxBool isVerified = false.obs;
  String phoneVerified = "";

  var size = Rx<Size>(Size.zero);
  late bool fromUserPage = true;
  StatusRequest statusRequest = StatusRequest.none;
  late TextEditingController phoneNumber;
  late TextEditingController emailPhone;
  late TextEditingController password;
  // used after validate
  late String validPhoneNumber;
  bool isValidPhoneNumber = false;

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> formstatePhone = GlobalKey<FormState>();
  @override
  goToOTP() {
    Get.toNamed(AppRoute.otp);
  }

  @override
  goToSignUp() {
    Get.toNamed(AppRoute.signUp);
  }

  @override
  goToHome() {
    Get.offAllNamed(AppRoute.home);
  }

  @override
  goToLoginPhone(arguments) {
    Get.toNamed(AppRoute.loginPhone, arguments: arguments);
  }

  void convertPhoneNumber() {
    String currentText = phoneNumber.text;
    if (currentText.startsWith("09")) {
      phoneNumber.text = "(+63) 9" + currentText.substring(2);
      validPhoneNumber = "+639" + currentText.substring(2);
      isValidPhoneNumber = true;
    } else if (currentText.startsWith("+639")) {
      phoneNumber.text = "(+63) 9" + currentText.substring(4);
      validPhoneNumber = "+639" + currentText.substring(4);
      isValidPhoneNumber = true;
    } else if (currentText.startsWith("(+63) 9")) {
      validPhoneNumber = "+639" + currentText.substring(7);
      isValidPhoneNumber = true;
    } else {
      isValidPhoneNumber = false;
    }
  }

  void googleSignin() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final userEmail = googleUser.email;
        statusRequest = StatusRequest.loading;
        update();
        var response = await loginController.emailLogin(userEmail);

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            final Map<String, dynamic>? addressData =
                response['address'] is Map<String, dynamic>
                    ? response['address']
                    : null;
            final Map<String, dynamic>? userData =
                response['data'] is Map<String, dynamic>
                    ? response['data']
                    : null;
            final Map<String, dynamic>? shopData =
                response['shop'] is Map<String, dynamic>
                    ? response['shop']
                    : null;
            if (userData != null) {
              await myServices.saveUser(userData);
            }
            if (shopData != null) {
              await myServices.saveShop(shopData);
            }
            if (addressData != null) {
              await myServices.saveAddress(addressData);
            }

            goToHome();
          } else {
            showErrorMessage(response['message']);
          }
        }
        update();
      } else {
        throw showErrorMessage("Google sign-in failed");
      }
    } catch (e) {
      throw showErrorMessage("Google sign-in failed");
    }
  }

  checkNumber() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await loginController.checkNumberSignin(validPhoneNumber);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        phoneAuthentication(validPhoneNumber);
        Get.toNamed(AppRoute.otp, arguments: {
          'phoneNumber': validPhoneNumber,
          'auth': "signIn",
        });
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  verifyOTP(String otp, String phoneNumber) async {
    phoneSignIn(otp, phoneNumber);
  }

  phoneSignIn(String otp, String phoneNumber) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      if (credentials.user != null) {
        phoneLogin();
      } else {
        showErrorMessage("Something went wrong. Please Try again");
      }
    } catch (e) {
      showErrorMessage(
          "Please check and enter the correct verification code again.");
    }
  }

  phoneLogin() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await loginController.phoneSignin(phoneVerified);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        isVerified.value = false;
        update();
        final Map<String, dynamic> userData = response['data'];
        final Map<String, dynamic>? addressData =
            response['address'] is Map<String, dynamic>
                ? response['address']
                : null;
        final Map<String, dynamic>? shopData =
            response['shop'] is Map<String, dynamic> ? response['shop'] : null;

        if (shopData != null) {
          await myServices.saveShop(shopData);
        }
        if (addressData != null) {
          await myServices.saveAddress(addressData);
        }
        await myServices.saveUser(userData);
        goToHome();
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

  @override
  loginValidate() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      if (emailPhone.text.startsWith("09")) {
        if (emailPhone.text.length == 11 &&
            emailPhone.text.substring(2).contains(RegExp(r'[0-9]{9}'))) {
          emailPhone.text = "+639" + emailPhone.text.substring(2);
        }
      }
      login();
    }
  }

  login() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await loginController.login(emailPhone.text, password.text);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        final Map<String, dynamic> addressData = response['address'];
        final Map<String, dynamic>? userData =
            response['data'] is Map<String, dynamic> ? response['data'] : null;
        final Map<String, dynamic>? shopData =
            response['shop'] is Map<String, dynamic> ? response['shop'] : null;
        if (userData != null) {
          await myServices.saveUser(userData);
        }
        if (shopData != null) {
          await myServices.saveShop(shopData);
        }
        await myServices.saveAddress(addressData);
        goToHome();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  @override
  loginPhone() {
    var formDataPhone = formstatePhone.currentState;
    isValidPhoneNumber = false;
    if (formDataPhone!.validate()) {
      convertPhoneNumber();
      if (isValidPhoneNumber) {
        checkNumber();
      }
    } else {
      isValidPhoneNumber = false;
    }
  }

  @override
  void onInit() {
    phoneNumber = TextEditingController();
    emailPhone = TextEditingController();
    password = TextEditingController();
    fromUserPage = Get.arguments?['fromUserPage'] ?? false;
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    emailPhone.dispose();
    password.dispose();
    super.dispose();
  }
}
