import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/order_item_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomItemOrderDetails extends StatelessWidget {
  const CustomItemOrderDetails({super.key, required this.orderItems});
  final OrderItemModels orderItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: orderItems.order.length,
        itemBuilder: ((context, index) {
          OrderItem orderItem = orderItems.order[index];
          String? price = orderItem.price;
          int? quantity = int.parse(orderItem.quantity!);
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.productProfile,
                  arguments: orderItem.productID);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color.fromARGB(8, 0, 0, 0),
              child: Row(children: [
                CachedNetworkImage(
                  imageUrl:
                      "${AppLink.productImage}${orderItem.productImageURL}",
                  fit: BoxFit.fill,
                  height: 75,
                  width: 75,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.black26,
                    highlightColor: Colors.white,
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderItem.productName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    orderItem.variationName == null ||
                            orderItem.variationName == "null"
                        ? Text("")
                        : Text(
                            "Variation: ${orderItem.variationName!} ",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₱${price}",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color.fromARGB(165, 0, 0, 0),
                                  ),
                        ),
                        Text(
                          "x${quantity}",
                          style: Theme.of(context).textTheme.headline6,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
              ]),
            ),
          );
        }));
  }
}
