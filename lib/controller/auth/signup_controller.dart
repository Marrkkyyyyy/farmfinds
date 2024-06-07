import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/handling_data_controller.dart';
import 'package:ecommerce/core/services/services.dart';
import 'package:ecommerce/data/datasource/remote/auth/signup.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class SignUpController extends GetxController {
  signup();
  signupSetPassword();
  goToLogin();
  goToHome();
  goToSetPassword(String auth);
}

class SignUpControllerImp extends SignUpController {
  SignupData signupController = SignupData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  RxBool isVerified = false.obs;
  String phoneVerified = "";
  String userEmail = '';
  String auth = '';
  String otp = "";
  late bool fromUserPage = false;
  var size = Rx<Size>(Size.zero);
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  GlobalKey<FormState> formstateSetPassword = GlobalKey<FormState>();

  late TextEditingController phoneNumber;
  late TextEditingController password;
  late TextEditingController cpassword;
  final _auth = FirebaseAuth.instance;
  var verificationId = '';

  // used after validate
  late String validPhoneNumber;
  bool isValidPhoneNumber = false;

  void convertPhoneNumber() {
    String currentText = phoneNumber.text;
    if (currentText.startsWith("09")) {
      phoneNumber.text = "(+63) 9" + currentText.substring(2);
      validPhoneNumber = "+639" + currentText.substring(2);
    } else if (currentText.startsWith("+639")) {
      phoneNumber.text = "(+63) 9" + currentText.substring(4);
      validPhoneNumber = "+639" + currentText.substring(4);
    } else if (currentText.startsWith("(+63) 9")) {
      validPhoneNumber = "+639" + currentText.substring(7);
    }
    isValidPhoneNumber = true;
  }

  void emailSignup() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await signupController.emailSignup(userEmail, password.text);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        isVerified.value = false;
        update();
        final Map<String, dynamic> userData = response['data'];
        await myServices.saveUser(userData);
        goToHome();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  void googleSignup() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final userEmail = googleUser.email;
        this.userEmail = userEmail;
        statusRequest = StatusRequest.loading;
        update();
        var response = await signupController.checkEmail(userEmail);

        statusRequest = handlingData(response);

        if (StatusRequest.success == statusRequest) {
          if (response['status'] == "success") {
            isVerified.value = true;
            update();
            goToSetPassword("email");
          } else {
            showErrorMessage(response['message']);
          }
        }
        update();
      } else {
        throw showErrorMessage("Google sign-up failed");
      }
    } catch (e) {
      throw showErrorMessage("Google sign-up failed");
    }
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
        update();
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId = verificationId;
        update();
      },
    );
  }

  verifyOTP(String otp, String phoneNumber) async {
    phoneSignUp(otp, phoneNumber);
  }

  phoneSignUp(String otp, String phoneNumber) async {
    try {
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: otp));

      if (credentials.user != null) {
        isVerified.value = true;
        phoneVerified = phoneNumber;
        update();
        goToSetPassword("phone");
      } else {
        showErrorMessage("Something went wrong. Please try again");
      }
    } catch (e) {
      showErrorMessage(
          "Please check and enter the correct verification code again");
    }
  }

  checkNumber() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await signupController.checkNumber(validPhoneNumber);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        phoneAuthentication(validPhoneNumber);
        Get.toNamed(AppRoute.otp, arguments: {
          'phoneNumber': validPhoneNumber,
          'auth': "signUp",
        });
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  phoneSignup() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await signupController.phoneSignup(phoneVerified, password.text);

    statusRequest = handlingData(response);

    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        isVerified.value = false;
        update();
        final Map<String, dynamic> userData = response['data'];
        await myServices.saveUser(userData);
        goToHome();
      } else {
        showErrorMessage(response['message']);
      }
    }
    update();
  }

  @override
  goToHome() {
    Get.offAllNamed(AppRoute.home);
  }

  @override
  goToLogin() {
    Get.toNamed(AppRoute.signUp);
  }

  @override
  signup() {
    var formData = formstate.currentState;
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

  @override
  signupSetPassword() {
    var formDataSetPassword = formstateSetPassword.currentState;
    if (formDataSetPassword!.validate()) {
      if (auth == "email") {
        emailSignup();
      } else {
        phoneSignup();
      }
    }
  }

  @override
  goToSetPassword(String auth) {
    this.auth = auth;
    update();
    if (auth == "phone") {
      Get.offNamed(AppRoute.setPassword);
    } else {
      Get.toNamed(AppRoute.setPassword);
    }
  }

  @override
  void onInit() {
    phoneNumber = TextEditingController();
    password = TextEditingController();
    cpassword = TextEditingController();
    fromUserPage = Get.arguments?['fromUserPage'] ?? false;
    size.value = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    super.onInit();
  }

  @override
  void dispose() {
    phoneNumber.dispose();
    password.dispose();
    cpassword.dispose();
    super.dispose();
  }
}
