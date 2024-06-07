import 'package:ecommerce/controller/address/address_selection_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/capitalize_each_word.dart';
import 'package:ecommerce/data/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../widget/order/custom_button_order.dart';

class AddressSelection extends StatelessWidget {
  AddressSelection({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressSelectionController());
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(12, 0, 0, 0),
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
          elevation: 2,
          leadingWidth: 34,
          title: const Text(
            "Address Selection",
          ),
        ),
        body: GetBuilder<AddressSelectionController>(builder: (controller) {
          return controller.statusRequest == StatusRequest.loading
              ? Center(
                  child: Lottie.asset(AppImageASset.loading,
                      width: 250, height: 250),
                )
              : controller.statusRequest == StatusRequest.offlinefailure
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.refreshData();
                          },
                          child: Text(
                            "Reload Page",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .34, 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            backgroundColor: Color.fromARGB(123, 0, 150, 135),
                          ),
                        ),
                        Center(
                          child: Lottie.asset(AppImageASset.offline,
                              width: 250, height: 250),
                        ),
                      ],
                    )
                  : controller.statusRequest == StatusRequest.serverfailure
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.refreshData();
                              },
                              child: Text(
                                "Reload Page",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              style: TextButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .34,
                                    35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor:
                                    Color.fromARGB(123, 0, 150, 135),
                              ),
                            ),
                            Center(
                              child: Lottie.asset(AppImageASset.server,
                                  width: 250, height: 250),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                color: Color.fromARGB(12, 0, 0, 0),
                                child: Text(
                                  "Address",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                              Column(
                                  children: List.generate(
                                      controller.addresses.length, (index) {
                                final address = controller.addresses[index];
                                return Obx(() {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        bottom:
                                            controller.addresses.length - 1 ==
                                                    index
                                                ? 8
                                                : 0),
                                    color: Colors.white,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Radio<AddressModel>(
                                          value: address,
                                          groupValue:
                                              controller.selectedAddress.value,
                                          onChanged: (selectedAddress) async {
                                            bool result = await controller
                                                .selectDefaultAddress(
                                                    selectedAddress!
                                                        .userAddressID!);

                                            if (result) {
                                              controller.selectedAddress.value =
                                                  selectedAddress;
                                              controller.myServices
                                                  .saveDefaultAddress(
                                                      userAddressID: selectedAddress
                                                          .userAddressID!,
                                                      status: "1",
                                                      addressID: int
                                                          .parse(selectedAddress
                                                              .addressID!),
                                                      userID:
                                                          selectedAddress
                                                              .userID!,
                                                      fullName:
                                                          selectedAddress
                                                              .fullName!,
                                                      phoneNumber: selectedAddress
                                                          .phoneNumber!,
                                                      selectedRegionName:
                                                          selectedAddress
                                                              .region!,
                                                      selectedProvince:
                                                          selectedAddress
                                                              .province!,
                                                      selectedMunicipality:
                                                          selectedAddress.city!,
                                                      selectedBarangay:
                                                          selectedAddress
                                                              .barangay!,
                                                      postalCode:
                                                          selectedAddress
                                                              .postalCode!,
                                                      streetName:
                                                          selectedAddress
                                                              .streetName!);

                                              Get.back(result: true);
                                            } else {}
                                          },
                                          activeColor: Colors.teal,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxWidth:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.52,
                                                    ),
                                                    child: Text(
                                                      address.fullName!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                            fontSize: 15,
                                                          ),
                                                    ),
                                                  ),
                                                  Text(
                                                    " | ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black54),
                                                  ),
                                                  Text(
                                                    address.phoneNumber!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black54),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                address.streetName!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black54),
                                              ),
                                              Text(
                                                capitalizeEachWord(
                                                    "${address.barangay}, ${address.city}, ${address.province}, ${address.postalCode}"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: Colors.black54),
                                              ),
                                              address.status == "1"
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          top: 6),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Color
                                                                  .fromARGB(
                                                                      172,
                                                                      244,
                                                                      67,
                                                                      54))),
                                                      child: Text("Default",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          172,
                                                                          244,
                                                                          67,
                                                                          54))),
                                                    )
                                                  : SizedBox(),
                                              SizedBox(height: 12),
                                              Divider(
                                                color:
                                                    Color.fromARGB(20, 0, 0, 0),
                                                thickness: 1,
                                                height: 0,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              }))
                            ],
                          ),
                        );
        }),
        bottomNavigationBar:
            GetBuilder<AddressSelectionController>(builder: (controller) {
          return controller.statusRequest == StatusRequest.loading ||
                  controller.statusRequest == StatusRequest.failure ||
                  controller.statusRequest == StatusRequest.offlinefailure ||
                  controller.statusRequest == StatusRequest.serverfailure
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x29000000),
                        offset: Offset(1, 0),
                        blurRadius: 5,
                        spreadRadius: 1.2,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: CustomButtonOrder(
                    color: Colors.teal,
                    function: () async {
                      final result = await Get.toNamed(AppRoute.addNewAddress);

                      if (result == true) {
                        controller.refreshData();
                      }
                    },
                    text: "Add New Address",
                    colorText: Colors.white,
                    colorBorder: Colors.transparent,
                  ),
                );
        }),
      ),
    );
  }
}
