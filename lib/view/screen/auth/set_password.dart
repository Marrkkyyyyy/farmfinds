import 'package:ecommerce/controller/auth/signup_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/auth/custom_navigator_form_auth.dart';
import 'package:ecommerce/view/widget/auth/custom_text_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SetPassword extends StatelessWidget {
  SetPassword({Key? key}) : super(key: key) {
    Get.put(SignUpControllerImp());
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
            "Sign Up",
          ),
        ),
        body: GetBuilder<SignUpControllerImp>(builder: (controller) {
          return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: controller.size.value.height * .1,
                ),
                child: Form(
                  key: controller.formstateSetPassword,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Set Your Password",
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black54),
                        ),
                      ),
                      SizedBox(
                        height: controller.size.value.height * .04,
                      ),
                      CustomTextFormAuth(
                          isObscureText: true,
                          hintText: "Password",
                          controller: controller.password,
                          valid: (val) {
                            return validInput(val, "password");
                          },
                          icon: Icons.lock),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormAuth(
                          isObscureText: true,
                          hintText: "Confirm Password",
                          controller: controller.cpassword,
                          valid: (val) {
                            if (val != controller.password.text) {
                              return "Passwords doesn't match";
                            } else {
                              return null;
                            }
                          },
                          icon: Icons.lock),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomNavigatorFormAuth(
                        text: "Login",
                        size: controller.size.value,
                        function: () {
                          controller.signupSetPassword();
                        },
                      ),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}
