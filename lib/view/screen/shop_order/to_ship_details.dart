import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/controller/shop_order/to_ship_details_controller.dart';
import 'package:ecommerce/view/widget/order/custom_info_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_item_order_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ToShipDetails extends StatelessWidget {
  ToShipDetails({super.key});
  final controller = Get.put(ToShipDetailsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
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
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomItemOrderDetails(orderItems: controller.orderItems),
                  Divider(
                    height: 20,
                    thickness: .25,
                    color: Colors.black38,
                  ),
                  CustomInfoOrderDetails(
                    merchandiseSubtotal:
                        controller.calculateMerchandiseSubtotal(),
                    shippingFee: controller.orderItems.order[0].shippingFee!,
                    orderTotal: controller.calculateAmountPayable(),
                    orderID: controller.orderItems.orderID!,
                    date: controller.orderDate!,
                    shippedDate: controller.shippedDate!,
                  ),
                  Divider(
                    height: 20,
                    thickness: .25,
                    color: Colors.black38,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: Text(
                    "Amount Payable: ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16, color: Colors.black54),
                  ),
                ),
                Text(
                  "₱${controller.calculateAmountPayable()}",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.teal,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
