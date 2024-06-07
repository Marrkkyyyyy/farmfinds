import 'package:ecommerce/controller/shop/shop/edit_pickup_address_controller.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_address_dropdown_textfield.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_address_textfield.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_address_title.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_region_address_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EditPickupAddress extends StatelessWidget {
  EditPickupAddress({Key? key}) : super(key: key) {
    Get.put(EditPickupAddressController());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  message:
                      "Are you sure you want to discard? Your address would not be saved.",
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () {
                    Navigator.pop(context);
                    Get.delete<EditPickupAddressController>();
                    Get.back();
                  },
                );
              });
          return true;
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(8, 0, 0, 0),
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ConfirmationDialog(
                          message:
                              "Are you sure you want to discard? Your address would not be saved.",
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onConfirm: () {
                            Navigator.pop(context);
                            Get.delete<EditPickupAddressController>();
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
            title: const Text(
              "New Address",
            ),
          ),
          body: GetBuilder<EditPickupAddressController>(builder: (controller) {
            return SingleChildScrollView(
              child: Form(
                key: controller.formstate,
                child: Column(
                  children: [
                    CustomAddressTitle(
                        size: controller.size.value, text: "Contact"),
                    CustomAddressTextfield(
                        controller: controller.fullName,
                        digitOnly: false,
                        keyboardType: TextInputType.text,
                        hint: "Full Name",
                        valid: (val) {
                          return validInput(val, "name");
                        }),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    CustomAddressTextfield(
                        controller: controller.phoneNumber,
                        digitOnly: false,
                        keyboardType: TextInputType.phone,
                        hint: "Phone number",
                        valid: (val) {
                          return validInput(val, "phoneNumberAddress");
                        }),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    CustomAddressTitle(
                        size: controller.size.value, text: "Address"),
                    CustomRegionAddressTextfield(
                        size: controller.size.value,
                        function: (val) {
                          controller.selectRegion(val!);
                          return null;
                        },
                        hint: "Region",
                        value: controller.selectedRegion,
                        items: controller.regionCodeData),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    controller.selectedRegion == null
                        ? const SizedBox()
                        : CustomAddressDropdownTextfield(
                            size: controller.size.value,
                            function: (val) {
                              controller.selectProvince(val!);
                              return null;
                            },
                            hint: "Province",
                            value: controller.selectedProvince,
                            items: controller.provinces),
                    controller.selectedProvince == null
                        ? const SizedBox()
                        : CustomAddressDropdownTextfield(
                            size: controller.size.value,
                            function: (val) {
                              controller.selectMunicipality(val!);
                              return null;
                            },
                            hint: "Municipality / City",
                            value: controller.selectedMunicipality,
                            items: controller.municipal),
                    controller.selectedMunicipality == null
                        ? const SizedBox()
                        : CustomAddressDropdownTextfield(
                            size: controller.size.value,
                            function: (val) {
                              controller.selectedBarangay = val;
                              controller.update();
                              return null;
                            },
                            hint: "Barangay",
                            value: controller.selectedBarangay,
                            items: controller.barangay),
                    CustomAddressTextfield(
                      controller: controller.postalCode,
                      hint: "Postal Code",
                      valid: (val) {
                        return validInput(val, "postal_code");
                      },
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    CustomAddressTextfield(
                        controller: controller.streetName,
                        digitOnly: false,
                        keyboardType: TextInputType.text,
                        hint: "Street Name, Building, House No.",
                        valid: (val) {
                          return validInput(val, "");
                        }),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          fixedSize:
                              Size(controller.size.value.width * .96, 45),
                          backgroundColor:
                              const Color.fromARGB(255, 31, 129, 121),
                          shape: const RoundedRectangleBorder()),
                      child: Text(
                        "Submit",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        controller.validateAddress();
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
