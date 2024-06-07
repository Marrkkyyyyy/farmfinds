import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/capitalize_each_word.dart';
import 'package:ecommerce/data/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../controller/address/address_controller.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/image_asset.dart';
import '../../widget/order/custom_button_order.dart';

class MyAddress extends StatelessWidget {
  MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController());
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
            "My Addresses",
          ),
        ),
        body: GetBuilder<AddressController>(builder: (controller) {
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
                      : controller.addresses.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No addresses found. \n Please add an address for delivery.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                            color: Colors.black54,
                                            fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Lottie.asset(
                                    AppImageASset.noProduct,
                                  ),
                                ],
                              ),
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
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
                                    AddressModel address =
                                        controller.addresses[index];
                                    return InkWell(
                                      onTap: () async {
                                        final result = await Get.toNamed(
                                          AppRoute.editAddress,
                                          arguments: {
                                            "addressData":
                                                controller.addresses[index],
                                          },
                                        );

                                        if (result == true) {
                                          controller.refreshData();
                                        }
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.fromLTRB(
                                            12,
                                            6,
                                            12,
                                            controller.addresses.length - 1 ==
                                                    index
                                                ? 8
                                                : 0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.6,
                                                      ),
                                                      child: Text(
                                                        address.fullName!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                              fontSize: 15,
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 0,
                                                    child: Text(
                                                      " | ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .black54),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      address.phoneNumber!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black54),
                                                    ),
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
                                            ]),
                                      ),
                                    );
                                  }))
                                ],
                              ),
                            );
        }),
        bottomNavigationBar:
            GetBuilder<AddressController>(builder: (controller) {
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
