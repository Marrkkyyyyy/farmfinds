import 'package:ecommerce/controller/cart/place_order_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPlaceOrderNavigation extends StatelessWidget {
  CustomPlaceOrderNavigation({super.key});
  final controller = Get.find<PlaceOrderController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x29000000),
                  offset: Offset(1, 0),
                  blurRadius: 3,
                  spreadRadius: .5,
                ),
              ],
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.event_note_outlined,
                      size: 20,
                      color: Colors.teal,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Payment Details",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Merchandise Subtotal:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54),
                        ),
                      ),
                      Text(
                        "₱${controller.TotalMerchandise.value}",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.teal,
                              fontWeight: FontWeight.w700,
                            ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Shipping Subtotal:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      Text(
                        "₱${controller.TotalShippingFee.value}",
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              color: Colors.teal,
                              fontWeight: FontWeight.w700,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Total Payment",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w600)),
                        RichText(
                            text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.teal),
                                text: '',
                                children: [
                              const TextSpan(
                                  text: "₱",
                                  style: TextStyle(
                                    fontSize: 12,
                                  )),
                              const TextSpan(text: ""),
                              TextSpan(
                                  text: "${controller.totalPayment.value}",
                                  style: const TextStyle(fontSize: 16)),
                            ])),
                      ],
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    GetBuilder<PlaceOrderController>(builder: (controller) {
                      return TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            fixedSize:
                                Size(controller.size.value.width * .3, 47),
                            backgroundColor:
                                const Color.fromARGB(255, 31, 129, 121),
                            shape: const RoundedRectangleBorder()),
                        onPressed:
                            controller.statusRequest == StatusRequest.loading ||
                                    controller.statusRequest ==
                                        StatusRequest.success
                                ? () {}
                                : () {
                                    controller.checkout();
                                  },
                        child: Text(
                          controller.statusRequest == StatusRequest.loading
                              ? "Processing"
                              : "Place Order",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
