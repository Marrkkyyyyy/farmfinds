import 'package:ecommerce/controller/order/order_details_controller.dart';
import 'package:ecommerce/core/constant/color.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/order/custom_button_order.dart';
import 'package:ecommerce/view/widget/order/custom_info_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_item_order_details.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name_order_details.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CompletedOrderDetails extends StatelessWidget {
  CompletedOrderDetails({super.key});
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
            Container(
              decoration: BoxDecoration(color: Colors.teal.shade400),
              width: controller.size.value.width,
              padding: EdgeInsets.only(left: 12, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order Completed",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.white),
                      text: '',
                      children: [
                        TextSpan(
                          text: "Thank you for Shopping with FarmFinds!",
                        ),
                      ],
                    ),
                  ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.truck,
                            color: Colors.teal,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Delivery Contact",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    fontWeight: FontWeight.w800, fontSize: 14),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: .7,
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person_outlined,
                            color: Colors.blueGrey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            controller.orderItems.deliveryFullName!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.blueGrey,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            controller.orderItems.deliveryPhoneNumber!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                    text: controller
                                        .orderItems.deliveryPhoneNumber!));
                                EasyLoading.showToast("copied to clipboard",
                                    duration: const Duration(seconds: 1),
                                    toastPosition:
                                        EasyLoadingToastPosition.bottom,
                                    maskType: EasyLoadingMaskType.none);
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.black54,
                                size: 18,
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SpacerWidget(
                    height: 6,
                    color: Color.fromARGB(205, 235, 235, 235),
                  ),
                  SizedBox(
                    height: 8,
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
                    date: controller.orderDate!,
                    shippedDate: controller.shippedDate!,
                    dateReceived: controller.dateReceived!,
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
      bottomNavigationBar: controller.orderItems.reviewID != "null"
          ? SizedBox()
          : Container(
              padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
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
                  CustomButtonOrder(
                      colorText: Colors.white,
                      colorBorder: Colors.transparent,
                      function: () {
                        Get.toNamed(AppRoute.rateProduct,
                            arguments: {"orderItems": controller.orderItems});
                      },
                      text: "Rate Product",
                      color: Colors.teal),
                ],
              ),
            ),
    );
  }
}
