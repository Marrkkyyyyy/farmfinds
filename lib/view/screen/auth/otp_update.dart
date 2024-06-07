import 'package:ecommerce/controller/home/edit_phone_controller.dart';
import 'package:ecommerce/view/widget/auth/otp_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OTPUpdatePage extends StatelessWidget {
  OTPUpdatePage({Key? key}) : super(key: key) {}
  final controller = Get.find<EditUserPhoneController>();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    // final String phoneNumber = arguments['phoneNumber'];
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const OTPLogo(),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Verification Code Required",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "To complete the verification process, please enter the code sent to you",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (code) async {
                  controller.otp = code;
                  controller.update();
                  // if (auth == "signIn") {
                  //   loginController.verifyOTP(controller.otp, phoneNumber);
                  // } else {
                  //   controller.verifyOTP(controller.otp, phoneNumber);
                  // }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
