import 'package:ecommerce/controller/order/order_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/view/widget/order/custom_amount_payable.dart';
import 'package:ecommerce/view/widget/order/custom_processing_order_item.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Cancelled extends StatelessWidget {
  Cancelled({Key? key});
  final controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.initData();
      },
      child: GetBuilder<OrderController>(builder: (controller) {
        return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: controller.cancelledOrders.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: controller.size.value.height * .15,
                        ),
                        Lottie.asset(AppImageASset.noProduct,
                            width: 200, height: 200),
                        Text(
                          "No orders yet",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Monitor your orders and check back here for updates.",
                          textAlign: TextAlign.center,
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
                          itemCount: controller.cancelledOrders.length,
                          itemBuilder: (BuildContext context, int shopIndex) {
                            OrderItemModels cancelOrders =
                                controller.cancelledOrders[shopIndex];
                            int totalQuantity = 0;
                            int totalAmountPayable = 0;
                            return InkWell(
                              onTap: () {
                                Get.toNamed(AppRoute.cancelledOrderDetails,
                                    arguments: {
                                      "orderItems": cancelOrders,
                                    });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomShopName(
                                    shopName: cancelOrders.shopName!,
                                    status: "Cancelled",
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (BuildContext context,
                                        int productIndex) {
                                      if (productIndex < 1) {
                                        OrderItem cancelOrder =
                                            cancelOrders.order[productIndex];
                                        String? price = cancelOrder.price;
                                        int? quantity =
                                            int.parse(cancelOrder.quantity!);

                                        for (var item in controller
                                            .cancelledOrders[shopIndex].order) {
                                          totalQuantity += 1;
                                          totalAmountPayable +=
                                              (int.parse(item.price!) *
                                                  int.parse(item.quantity!));
                                        }
                                        if (controller
                                                .cancelledOrders[shopIndex]
                                                .order
                                                .length >
                                            1) {
                                          return Column(
                                            children: [
                                              CustomOrderItem(
                                                  orderItem: cancelOrder,
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
                                              orderItem: cancelOrder,
                                              price: price!,
                                              quantity: quantity);
                                        }
                                      } else {
                                        totalAmountPayable += int.parse(
                                            cancelOrders.order[0].shippingFee!);
                                        return CustomAmountPayable(
                                            payableText: "Order Total",
                                            color: Colors.teal,
                                            text: "Buy Again",
                                            function: () {
                                              controller.buyAgain(
                                                  controller
                                                      .cancelledOrders[
                                                          shopIndex]
                                                      .userOrderID,
                                                  controller.cancelledOrders[
                                                      shopIndex]);
                                            },
                                            totalQuantity: totalQuantity,
                                            totalAmountPayable:
                                                totalAmountPayable);
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
