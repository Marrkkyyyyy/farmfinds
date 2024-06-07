import 'package:ecommerce/controller/cart/place_order_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/cart/custom_address_place_order.dart';
import 'package:ecommerce/view/widget/cart/custom_item_place_order.dart';
import 'package:ecommerce/view/widget/cart/custom_place_order_navigation.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PlaceOrder extends StatelessWidget {
  PlaceOrder({super.key});
  final controller = Get.put(PlaceOrderController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
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
            elevation: 2,
            leadingWidth: 34,
            title: Text(
              "Checkout",
            ),
          ),
          body: GetBuilder<PlaceOrderController>(
              init: PlaceOrderController(),
              initState: (_) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (controller.addressID.value == 0) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return WillPopScope(
                          onWillPop: () async {
                            return false;
                          },
                          child: ConfirmationDialog(
                            message:
                                "You don't have a delivery address yet, please add one before proceeding.",
                            onCancel: () {
                              Navigator.pop(context);
                              Get.back();
                            },
                            confirmText: "Ok",
                            onConfirm: () async {
                              Navigator.pop(context);
                              final result =
                                  await Get.toNamed(AppRoute.addNewAddress);
                              if (result == true) {
                                controller.addressID.value = controller
                                    .myServices
                                    .getAddress()?["addressID"];
                                controller.fullName = controller.myServices
                                    .getAddress()?["fullName"];
                                controller.phoneNumber = controller.myServices
                                    .getAddress()?["phoneNumber"];
                                controller.province = controller.myServices
                                    .getAddress()?["province"];
                                controller.city =
                                    controller.myServices.getAddress()?["city"];
                                controller.barangay = controller.myServices
                                    .getAddress()?["barangay"];
                                controller.streetName = controller.myServices
                                    .getAddress()?["streetName"];
                                int? postalCodeInt = controller.myServices
                                    .getAddress()?["postalCode"];
                                controller.postalCode =
                                    postalCodeInt?.toString() ?? "";
                                controller.update();
                              }
                              if (result == false) {
                                Get.back();
                              }
                            },
                          ),
                        );
                      },
                    );
                  }
                });
              },
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAddressPlaceOrder(),
                      CustomItemPlaceOrder(),
                    ],
                  ),
                );
              }),
          bottomNavigationBar: CustomPlaceOrderNavigation()),
    );
  }
}
