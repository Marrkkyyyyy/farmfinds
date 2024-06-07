import 'package:ecommerce/controller/home/edit_email_controller.dart';
import 'package:ecommerce/view/widget/auth/otp_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pinput/pinput.dart';

class ChangeEmailOTP extends StatelessWidget {
  ChangeEmailOTP({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmailController());
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
                  controller.verifyEmail(code);
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
