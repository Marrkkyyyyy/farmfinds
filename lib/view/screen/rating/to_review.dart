import 'package:ecommerce/controller/reviews/to_review_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/order/custom_amount_payable.dart';
import 'package:ecommerce/view/widget/order/custom_processing_order_item.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';

class ToReview extends StatelessWidget {
  ToReview({Key? key});
  final controller = Get.put(ToReviewController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.initData();
      },
      child: GetBuilder<ToReviewController>(builder: (controller) {
        return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: controller.toRateOrders.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: controller.size.value.height * .15,
                        ),
                        Lottie.asset(AppImageASset.noProduct,
                            width: 200, height: 200),
                        Text(
                          "No product to rate",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "There is no product to rate now.",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: controller.toRateOrders.length,
                          itemBuilder: (BuildContext context, int shopIndex) {
                            OrderItemModels toRateOrders =
                                controller.toRateOrders[shopIndex];
                            int totalQuantity = 0;
                            int totalAmountPayable = 0;
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AppRoute.completedOrderDetails,
                                    arguments: {"orderItems": toRateOrders});
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomShopName(
                                    shopName: toRateOrders.shopName!,
                                    status: "To Review",
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (BuildContext context,
                                        int productIndex) {
                                      if (productIndex < 1) {
                                        OrderItem toRateOrder =
                                            toRateOrders.order[productIndex];
                                        String? price = toRateOrder.price;
                                        int? quantity =
                                            int.parse(toRateOrder.quantity!);

                                        for (var item in controller
                                            .toRateOrders[shopIndex].order) {
                                          totalQuantity += 1;
                                          totalAmountPayable +=
                                              (int.parse(item.price!) *
                                                  int.parse(item.quantity!));
                                        }

                                        if (controller.toRateOrders[shopIndex]
                                                .order.length >
                                            1) {
                                          return Column(
                                            children: [
                                              CustomOrderItem(
                                                  orderItem: toRateOrder,
                                                  price: price!,
                                                  quantity: quantity),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Divider(
                                                height: 12,
                                              ),
                                              Text("View more product"),
                                              Divider(
                                                height: 8,
                                              ),
                                            ],
                                          );
                                        } else {
                                          return CustomOrderItem(
                                              orderItem: toRateOrder,
                                              price: price!,
                                              quantity: quantity);
                                        }
                                      } else {
                                        totalAmountPayable += int.parse(
                                            toRateOrders.order[0].shippingFee!);
                                        return CustomAmountPayable(
                                          payableText: "Order Total",
                                          color: Colors.teal,
                                          text: "  Rate  ",
                                          function: () {
                                            Get.toNamed(AppRoute.rateProduct,
                                                arguments: {
                                                  "orderItems": toRateOrders
                                                });
                                          },
                                          totalQuantity: totalQuantity,
                                          totalAmountPayable:
                                              totalAmountPayable,
                                          driver:
                                              toRateOrders.deliveryFullName!,
                                          dateReceived:
                                              toRateOrders.dateReceived!,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ));
      }),
    );
  }
}
