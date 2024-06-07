import 'package:ecommerce/controller/order/order_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/view/widget/order/custom_button_order.dart';
import 'package:ecommerce/view/widget/order/custom_header_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_info_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_item_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_order_details_navigation.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name_order_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../widget/confirmation_dialog.dart';

class ProcessingOrderDetails extends StatelessWidget {
  ProcessingOrderDetails({super.key});
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
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeaderOrderDetails(size: controller.size.value),
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
                      date: controller.orderDate!),
                  Divider(
                    height: 20,
                    thickness: .25,
                    color: Colors.black38,
                  ),
                  CustomButtonOrder(
                      colorText: Color.fromARGB(171, 0, 0, 0),
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return ConfirmationDialog(
                                  message: "Do you want to cancel this order?",
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  onConfirm: () {
                                    Navigator.pop(context);
                                    controller.cancelOrder();
                                  });
                            });
                      },
                      text: "Cancel Order"),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomOrderDetailsNavigation(
          amountPayable: controller.orderItems.subtotal!),
    );
  }
}
