import 'package:ecommerce/controller/shop/shop_registration/shop_requirements_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/auth/custom_text_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BindPhoneNumber extends StatelessWidget {
  BindPhoneNumber({super.key});
  final controller = Get.put(ShopRequirementsController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 8.0),
                child: const FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal,
                  size: 20,
                ),
              )),
          leadingWidth: 34,
          title: const Text("Add Phone Number"),
          actions: [
            Obx(() {
              return controller.isVerified.value
                  ? IconButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.otpBind, arguments: {
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
        body: GetBuilder<ShopRequirementsController>(builder: (controller) {
          return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formstateBind,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      CustomTextFormAuth(
                          keyboardType: TextInputType.phone,
                          hintText: "Phone Number",
                          controller: controller.bindPhoneNumber,
                          valid: (val) {
                            return validInput(val, "phoneNumber");
                          },
                          icon: Icons.call),
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            fixedSize:
                                Size(controller.size.value.width * 1, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 31, 129, 121),
                            shape: const RoundedRectangleBorder()),
                        child: Text(
                          "Next",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: () async {
                          controller.validatePhoneBind();
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
