import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart/place_order_controller.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomItemPlaceOrder extends StatelessWidget {
  CustomItemPlaceOrder({super.key});
  final controller = Get.find<PlaceOrderController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.shopItems.length,
        itemBuilder: (context, index) {
          String shopName = controller.shopItems.keys.elementAt(index);
          controller.products.value = controller.shopItems[shopName]!;
          int orderTotal = controller.products.length;
          int totalShopItem = 0;

          int shippingFee = 25;
          for (var product in controller.products) {
            String? price = product.price == null || product.price == "null"
                ? product.originalPrice
                : product.price;
            totalShopItem += int.parse(price!) * int.parse(product.quantity!);
          }
          totalShopItem += shippingFee;
          return Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 8,
                      right: 12,
                    ),
                    child: Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.store,
                          color: Colors.teal,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "$shopName",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.products.map((product) {
                  String image = product.imageURL!;
                  String productName = product.productName!;
                  String variationName = product.variationName ?? "";
                  String? price =
                      product.price == null || product.price == "null"
                          ? product.originalPrice
                          : product.price;
                  int quantity = int.parse(product.quantity!);

                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(8),
                    color: const Color.fromARGB(6, 0, 0, 0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: "${AppLink.productImage}${image}",
                          fit: BoxFit.fill,
                          height: 75,
                          width: 75,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.black26,
                            highlightColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.black26,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$productName",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            variationName != ""
                                ? Text("Variation: $variationName",
                                    style:
                                        Theme.of(context).textTheme.headline6!)
                                : Text(""),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₱$price",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            const Color.fromARGB(185, 0, 0, 0),
                                      ),
                                ),
                                Text(
                                  "x$quantity",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Shipping Cost:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black54),
                        ),
                        Text(
                          "₱$shippingFee",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.teal,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const SpacerWidget(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order Total ($orderTotal Item):",
                            style: Theme.of(context).textTheme.headline5),
                        Text(
                          "₱$totalShopItem",
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.teal,
                                  ),
                        )
                      ],
                    ),
                  ),
                  const SpacerWidget(),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
