import 'package:ecommerce/controller/home/edit_name_controller.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UpdateName extends StatelessWidget {
  UpdateName({super.key});
  final controller = Get.put(UpdateNameController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: WillPopScope(
          onWillPop: controller.onSave.value
              ? () async {
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
                }
              : () async {
                  return true;
                },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(4, 0, 0, 0),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: controller.onSave.value
                      ? () {
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
                        }
                      : () {
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
              elevation: 2,
              leadingWidth: 34,
              title: Text(
                "Edit Name",
              ),
              actions: [
                TextButton(
                    onPressed: controller.onSave.value
                        ? () {
                            controller.Validate();
                          }
                        : () {},
                    child: Text(
                      "Save",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 14,
                          color: controller.onSave.value
                              ? Colors.teal
                              : Colors.black38,
                          fontWeight: FontWeight.w600),
                    ))
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
                        if (val == null || val.length < 5) {
                          return 'Please enter at least 5 characters';
                        }

                        return null;
                      },
                      onChanged: (val) {
                        if (val == controller.textFieldName) {
                          controller.onSave.value = false;
                        } else {
                          controller.onSave.value = true;
                        }
                      },
                      controller: controller.fullNameController,
                      decoration: InputDecoration(
                        focusedErrorBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 1)),
                        errorMaxLines: 2,
                        errorStyle: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 13, color: Colors.red),
                        hintText: "Enter your name",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.black45),
                        prefixIcon: Icon(
                          Icons.person,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
