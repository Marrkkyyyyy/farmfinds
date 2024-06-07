import 'package:ecommerce/controller/order/order_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/order/custom_info_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_item_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name_order_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CancelledOrderDetails extends StatelessWidget {
  CancelledOrderDetails({super.key});
  final controller = Get.put(OrderDetailsController());
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
        title: const Text("Cancellation Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: controller.size.value.width,
              padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cancellation Completed",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 18,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          controller.dateCancelled!,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black38),
                        ),
                      ],
                    ),
                  ),
                  FaIcon(FontAwesomeIcons.circleCheck,
                      color: Colors.teal, size: 50)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomShopNameOrderDetails(
                      shopName: controller.orderItems.shopName!),
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
                      orderTotal: int.parse(controller.orderItems.subtotal!),
                      orderID: controller.orderItems.orderID!,
                      date: controller.dateCancelled!),
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
    );
  }
}
