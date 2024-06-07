import 'package:ecommerce/controller/auth/login_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/auth/custom_account_question.dart';
import 'package:ecommerce/view/widget/auth/custom_auth_navigator.dart';
import 'package:ecommerce/view/widget/auth/custom_navigator_form_auth.dart';
import 'package:ecommerce/view/widget/auth/custom_or_auth.dart';
import 'package:ecommerce/view/widget/auth/custom_phone_password_login.dart';
import 'package:ecommerce/view/widget/auth/custom_text_form_auth.dart';
import 'package:ecommerce/view/widget/auth/google_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widget/auth/custom_buttom_form_auth.dart';

class LoginPhone extends StatelessWidget {
  LoginPhone({Key? key}) : super(key: key);
  final controller = Get.put(LoginControllerImp());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 15),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal,
                  size: 20,
                ),
              ),
            ),
          ),
          title: const Text(
            "Log In",
          ),
          actions: [
            Obx(() {
              return controller.isVerified.value
                  ? IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.otp, arguments: {
                          "auth": "signIn",
                          "phoneNumber": controller.phoneVerified
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ))
                  : Container();
            })
          ],
        ),
        body: GetBuilder<LoginControllerImp>(builder: (controller) {
          return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: controller.size.value.height * .1,
                  ),
                  child: Form(
                    key: controller.formstatePhone,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Center(
                          child: FaIcon(
                            FontAwesomeIcons.lock,
                            size: 50,
                          ),
                        ),
                        SizedBox(
                          height: controller.size.value.height * .04,
                        ),
                        CustomTextFormAuth(
                            keyboardType: TextInputType.phone,
                            hintText: "Phone Number",
                            controller: controller.phoneNumber,
                            valid: (val) {
                              return validInput(val, "phoneNumber");
                            },
                            icon: Icons.call),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomNavigatorFormAuth(
                          text: "Next",
                          size: controller.size.value,
                          function: () {
                           
                            controller.loginPhone();
                          },
                        ),
                        CustomPhonePasswordLogin(
                            text: "Login with Password",
                            function: () {
                              Get.back();
                            }),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const CustomOrAuth(),
                        ),
                        CustomButtonFormAuth(
                            logo: const GoogleLogo(),
                            function: () {
                              controller.googleSignin();
                            },
                            text: "Login with Google"),
                        SizedBox(
                          height: controller.size.value.height * .02,
                        ),
                        controller.fromUserPage
                            ? const SizedBox()
                            : Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CustomAccountQuestion(
                                        text: 'Don\'t have an account?'),
                                    const SizedBox(width: 4),
                                    CustomAuthNavigator(
                                        text: "Sign up",
                                        function: () {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          controller.goToSignUp();
                                        }),
                                  ],
                                ))
                      ],
                    ),
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
