import 'package:ecommerce/controller/auth/login_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/auth/custom_navigator_form_auth.dart';
import 'package:ecommerce/view/widget/auth/custom_or_auth.dart';
import 'package:ecommerce/view/widget/auth/custom_text_form_auth.dart';
import 'package:ecommerce/view/widget/auth/google_logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widget/auth/custom_buttom_form_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key) {
    Get.put(LoginControllerImp());
  }
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
                    key: controller.formstate,
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
                            hintText: "Email",
                            controller: controller.emailPhone,
                            valid: (val) {
                              return validInput(val, "");
                            },
                            icon: Icons.person),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextFormAuth(
                            isObscureText: true,
                            hintText: "Password",
                            controller: controller.password,
                            valid: (val) {
                              return validInput(val, "");
                            },
                            icon: Icons.lock),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomNavigatorFormAuth(
                          text: "Login",
                          size: controller.size.value,
                          function: () {
                            controller.loginValidate();
                          },
                        ),
                        // CustomPhonePasswordLogin(
                        //     text: "Login with Phone Number",
                        //     function: () {
                        //       controller
                        //           .goToLoginPhone(controller.fromUserPage);
                        //     }),
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
                        // controller.fromUserPage
                        //     ? const SizedBox()
                        //     : Container(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 12),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [
                        //             const CustomAccountQuestion(
                        //                 text: 'Don\'t have an account?'),
                        //             const SizedBox(width: 4),
                        //             CustomAuthNavigator(
                        //                 text: "Sign up",
                        //                 function: () {
                        //                   FocusScope.of(context)
                        //                       .requestFocus(FocusNode());
                        //                   controller.goToSignUp();
                        //                 })
                        //           ],
                        //         ))
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
