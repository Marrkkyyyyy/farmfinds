import 'package:ecommerce/controller/shop_order/shop_order_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/view/widget/order/custom_processing_order_item.dart';
import 'package:ecommerce/view/widget/order/custom_shop_name.dart';
import 'package:ecommerce/view/widget/shop_order/custom_shop_order_total.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProcessingOrders extends StatelessWidget {
  ProcessingOrders({super.key});
  final controller = Get.find<ShopOrderController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.initData();
      },
      child: GetBuilder<ShopOrderController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: controller.processingOrders.isEmpty
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
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        itemCount: controller.processingOrders.length,
                        itemBuilder: (BuildContext context, int shopIndex) {
                          OrderItemModels processingOrders =
                              controller.processingOrders[shopIndex];
                          int totalQuantity = 0;
                          int totalAmountPayable = 0;
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoute.toShipDetails,
                                  arguments: {"orderItems": processingOrders});
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomShopName(
                                  shopName: processingOrders.shopName!,
                                  status: "To Ship",
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int productIndex) {
                                    if (productIndex < 1) {
                                      OrderItem processingOrder =
                                          processingOrders.order[productIndex];
                                      String? price = processingOrder.price;
                                      int? quantity =
                                          int.parse(processingOrder.quantity!);
                                      for (var item in controller
                                          .processingOrders[shopIndex].order) {
                                        totalQuantity += 1;
                                        totalAmountPayable +=
                                            (int.parse(item.price!) *
                                                int.parse(item.quantity!));
                                      }
                                      if (controller.processingOrders[shopIndex]
                                              .order.length >
                                          1) {
                                        return Column(
                                          children: [
                                            CustomOrderItem(
                                                orderItem: processingOrder,
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
                                            orderItem: processingOrder,
                                            price: price!,
                                            quantity: quantity);
                                      }
                                    } else {
                                      totalAmountPayable += int.parse(
                                          processingOrders
                                              .order[0].shippingFee!);
                                      return CustomShopOrderTotal(
                                        userOrder: processingOrders,
                                        totalQuantity: totalQuantity,
                                        totalAmountPayable: totalAmountPayable,
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
                ),
        );
      }),
    );
  }
}
