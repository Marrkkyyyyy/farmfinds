import 'package:ecommerce/controller/shop/shop_registration/shop_requirements_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_set_address_registraion.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_set_shop_registration.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_shop_textfield.dart';
import 'package:ecommerce/view/widget/start_selling/shop_registration/custom_title_shop_registration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ShopRegistration extends StatelessWidget {
  ShopRegistration({Key? key}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopRequirementsController());
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
            title: const Text("Set Shop Information"),
          ),
          body: GetBuilder<ShopRequirementsController>(builder: (controller) {
            return controller.statusRequest == StatusRequest.loading
                ? Center(
                    child: Lottie.asset(AppImageASset.loading,
                        width: 250, height: 250),
                  )
                : controller.statusRequest == StatusRequest.serverfailure
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Server failure. Please check your internet connection and refresh the page",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.black54),
                            ),
                            Center(
                              child: Lottie.asset(AppImageASset.server,
                                  width: 200, height: 200),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.statusRequest = StatusRequest.none;
                                controller.update();
                              },
                              child: Text(
                                "Reload page",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                fixedSize:
                                    Size(controller.size.value.width * .3, 35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                backgroundColor:
                                    Color.fromARGB(139, 96, 125, 139),
                              ),
                            )
                          ],
                        ),
                      )
                    : controller.statusRequest == StatusRequest.offlinefailure
                        ? Center(
                            child: Lottie.asset(AppImageASset.offline,
                                width: 200, height: 200),
                          )
                        : SingleChildScrollView(
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              key: controller.formstate,
                              child: Column(children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          Color.fromARGB(28, 0, 0, 0),
                                      child: controller.image != null
                                          ? ClipOval(
                                              child: Image.file(
                                                controller.image!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 50,
                                              color: Colors.blueGrey,
                                            ),
                                    ),
                                    Positioned(
                                      right: 0.0,
                                      bottom: 0.0,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.pickImage();
                                        },
                                        child: Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(193, 0, 0, 0),
                                          ),
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.camera,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 16),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const CustomTitleShopRegistration(
                                              title: "Shop Name"),
                                          Obx(() {
                                            return Text(
                                              "${controller.shopCharacterCount.value} / 30",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54,
                                                  ),
                                            );
                                          })
                                        ],
                                      ),
                                      CustomShopTextfield(
                                        function: (_) {
                                          controller.updateCharacterCount();
                                          return null;
                                        },
                                        controller: controller.shopName,
                                        hint: "Input",
                                        valid: (val) {
                                          return validInput(val, "shop_name");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SpacerWidget(),
                                Container(
                                  width: Get.width,
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 1),
                                          blurRadius: .5,
                                          spreadRadius: .5,
                                        ),
                                      ]),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomTitleShopRegistration(
                                            title: "Pickup Address"),
                                        Obx(() {
                                          return CustomSetAddressRegistration(
                                              color: controller
                                                          .pickupRegion.value ==
                                                      ""
                                                  ? Colors.black45
                                                  : Colors.black87,
                                              function: controller
                                                          .pickupRegion.value !=
                                                      ""
                                                  ? () {}
                                                  : () async {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              FocusNode());
                                                      final result =
                                                          await Get.toNamed(
                                                              AppRoute
                                                                  .addNewAddress,
                                                              arguments: {
                                                            "shopAddress": "1"
                                                          });

                                                      if (result == true) {
                                                        controller
                                                            .pickupFullName
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "fullName"];
                                                        controller
                                                            .pickupPhoneNumber
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "phoneNumber"];
                                                        controller.pickupRegion
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "region"];
                                                        controller
                                                            .pickupProvince
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "province"];
                                                        controller
                                                            .pickupMunicipal
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "city"];
                                                        controller
                                                            .pickupBarangay
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "barangay"];
                                                        controller
                                                            .pickupPostalCode
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "postalCode"];
                                                        controller
                                                            .pickupStreetName
                                                            .value = controller
                                                                .myServices
                                                                .getPickupData()?[
                                                            "streetName"];
                                                      }
                                                    },
                                              text: controller
                                                          .pickupRegion.value ==
                                                      ""
                                                  ? "Set"
                                                  : "${controller.pickupMunicipal.value}, ${controller.pickupBarangay.value}, ${controller.pickupStreetName.value}, ${controller.pickupPostalCode.value}",
                                              isVerified: controller
                                                          .pickupRegion.value ==
                                                      ""
                                                  ? false
                                                  : true);
                                        })
                                      ]),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 1),
                                          blurRadius: .5,
                                          spreadRadius: .5,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomTitleShopRegistration(
                                                title: "Email"),
                                            CustomSetShopRegistration(
                                              color: controller.email != "null"
                                                  ? Colors.black87
                                                  : Colors.black45,
                                              isPhone: false,
                                              function:
                                                  controller.email != "null"
                                                      ? () {}
                                                      : () {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  FocusNode());
                                                          controller.google();
                                                        },
                                              text: controller.email != "null"
                                                  ? controller.email!
                                                  : "Set",
                                              isVerified:
                                                  controller.email != "null"
                                                      ? true
                                                      : false,
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 1),
                                          blurRadius: .5,
                                          spreadRadius: .5,
                                        ),
                                      ]),
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const CustomTitleShopRegistration(
                                                title: "Phone Number"),
                                            CustomSetShopRegistration(
                                                color: controller.phoneNumber !=
                                                        "null"
                                                    ? Colors.black87
                                                    : Colors.black45,
                                                isVerified:
                                                    controller.phoneNumber !=
                                                            "null"
                                                        ? true
                                                        : false,
                                                isPhone: true,
                                                text: controller.phoneNumber !=
                                                        "null"
                                                    ? controller.phoneNumber!
                                                    : "Set",
                                                function: controller
                                                            .phoneNumber !=
                                                        "null"
                                                    ? () {}
                                                    : () {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());

                                                        Get.toNamed(AppRoute
                                                            .bindPhoneNumber);
                                                      })
                                          ]),
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          );
          }),
          bottomNavigationBar: Obx(() {
            return Container(
              padding: const EdgeInsets.all(5),
              color: Colors.white,
              child: TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .8, 47),
                  shape: const RoundedRectangleBorder(),
                  backgroundColor: controller.pickupRegion.value != "" &&
                          controller.email != "" &&
                          controller.email != "null" &&
                          controller.phoneNumber != ""
                      ? const Color.fromARGB(255, 31, 129, 121)
                      : Colors.black12,
                ),
                onPressed: () async {
                  controller.validateShop(context);
                },
                child: Text(
                  "SUBMIT",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 16,
                        color: controller.pickupRegion.value != "" &&
                                controller.email != "" &&
                                controller.email != "null" &&
                                controller.phoneNumber != ""
                            ? Colors.white
                            : Colors.black45,
                      ),
                ),
              ),
            );
          })),
    );
  }
}
