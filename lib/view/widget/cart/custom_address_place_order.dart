import 'package:ecommerce/controller/cart/place_order_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/cart/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomAddressPlaceOrder extends StatelessWidget {
  CustomAddressPlaceOrder({super.key});
  final controller = Get.find<PlaceOrderController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(AppRoute.addressSelection,
            arguments: {"addressID": controller.addressID.value});
        if (result == true) {
          controller.fullName = controller.myServices.getAddress()?["fullName"];
          controller.phoneNumber =
              controller.myServices.getAddress()?["phoneNumber"];
          controller.streetName =
              controller.myServices.getAddress()?["streetName"];
          controller.barangay = controller.myServices.getAddress()?["barangay"];
          controller.city = controller.myServices.getAddress()?["city"];
          controller.province = controller.myServices.getAddress()?["province"];
          controller.postalCode =
              controller.myServices.getAddress()?["postalCode"].toString();
          controller.addressID.value =
              controller.myServices.getAddress()?["addressID"];
          controller.update();
        }
      },
      child: Container(
        decoration: const BoxDecoration(color: Color.fromARGB(6, 0, 0, 0)),
        padding: const EdgeInsets.only(
          top: 8,
          left: 5,
          right: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 6,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.teal,
                    size: 20,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 28, top: 2),
                  width: controller.size.value.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Address",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontSize: 15),
                      ),
                      controller.addressID.value == 0
                          ? Text(
                              "Please select address",
                              style: Theme.of(context).textTheme.headline6,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "${controller.fullName}",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      " | ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 18,
                                              color: Colors.black54),
                                    ),
                                    Text(
                                      "${controller.phoneNumber}",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                                Text(
                                  "${controller.streetName}, ${controller.barangay}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.city}, ${controller.province}, ${controller.postalCode}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            CustomPaint(
              painter: DottedLinePainter(
                color: Colors.teal,
                strokeWidth: 3,
                gapWidth: 5.0,
                dashWidth: 20.0,
              ),
              child: SizedBox(
                width: controller.size.value.width,
                height: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
