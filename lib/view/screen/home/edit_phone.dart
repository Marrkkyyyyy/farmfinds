import 'package:ecommerce/controller/home/edit_phone_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UpdateUserPhone extends StatelessWidget {
  UpdateUserPhone({super.key});
  final controller = Get.put(EditUserPhoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(4, 0, 0, 0),
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
        actions: [
          Obx(() {
            return controller.isVerified.value
                ? IconButton(
                    onPressed: () {
                      Get.toNamed(AppRoute.otpUpdate,
                          arguments: {"phoneNumber": controller.phoneVerified});
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ))
                : Container();
          })
        ],
        elevation: 2,
        leadingWidth: 34,
        title: Text(
          "Edit Phone",
        ),
      ),
      body: GetBuilder<EditUserPhoneController>(builder: (controller) {
        return Container(
          padding: EdgeInsets.all(12),
          child: Column(children: [
            Form(
                key: controller.formSate,
                child: TextFormField(
                  controller: controller.phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (val) {
                    return validInput(val, "phoneNumber");
                  },
                  onChanged: (val) {
                    if (val == controller.phoneNumber) {
                      controller.onSave.value = false;
                    } else {
                      controller.onSave.value = true;
                    }
                  },
                  decoration: InputDecoration(
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1)),
                    errorMaxLines: 2,
                    errorStyle: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 13, color: Colors.red),
                    hintText: "New Phone Number",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.black45),
                    prefixIcon: Icon(
                      Icons.call,
                      color: Colors.teal,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: .5,
                      ),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 1.0,
                      ),
                    ),
                    prefixStyle: Theme.of(context).textTheme.headline5,
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            Obx(() {
              return TextButton(
                style: TextButton.styleFrom(
                    fixedSize: Size(controller.size.value.width * 1, 40),
                    backgroundColor: controller.onSave.value
                        ? const Color.fromARGB(255, 31, 129, 121)
                        : Colors.black12,
                    shape: const RoundedRectangleBorder()),
                child: Text(
                  "Next",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: controller.onSave.value
                          ? Colors.white
                          : Colors.black45),
                ),
                onPressed: controller.onSave.value
                    ? () {
                        controller.updatePhone();
                      }
                    : () {},
              );
            })
          ]),
        );
      }),
    );
  }
}
