import 'package:ecommerce/controller/home/edit_email_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UpdateEmail extends StatelessWidget {
  UpdateEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateEmailController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  confirmText: "Discard",
                  message: "Discard Changes?",
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () {
                    Navigator.pop(context);
                    Get.back();
                  },
                );
              });
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(4, 0, 0, 0),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          confirmText: "Discard",
                          message: "Discard Changes?",
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onConfirm: () {
                            Navigator.pop(context);
                            Get.back();
                          },
                        );
                      });
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
            elevation: 2,
            leadingWidth: 34,
            title: Text(
              "Change Email",
            ),
            actions: [
              Obx(() {
                return controller.isSent.value
                    ? IconButton(
                        onPressed: () {
                          Get.toNamed(AppRoute.changeEmailOTP);
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black54,
                        ))
                    : SizedBox();
              })
            ],
          ),
          body: Form(
            key: controller.formSate,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty || !val.isEmail) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      if (val.isEmail) {
                        controller.isEmail.value = true;
                      } else {
                        controller.isEmail.value = false;
                      }
                    },
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 1)),
                      errorMaxLines: 2,
                      errorStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 13, color: Colors.red),
                      hintText: "Enter email address",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black45),
                      prefixIcon: Icon(
                        Icons.email,
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
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Obx(() {
                    return TextButton(
                      style: TextButton.styleFrom(
                          fixedSize: Size(controller.size.value.width * 1, 40),
                          backgroundColor: controller.isEmail.value
                              ? const Color.fromARGB(255, 31, 129, 121)
                              : Colors.black26,
                          shape: const RoundedRectangleBorder()),
                      child: Text(
                        "Next",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: controller.isEmail.value
                                ? Colors.white
                                : Colors.black38),
                      ),
                      onPressed:
                          controller.statusRequest == StatusRequest.loading
                              ? () {}
                              : () {
                                  controller.Validate();
                                },
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
