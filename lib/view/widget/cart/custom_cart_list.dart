import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/cart/cart_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_shop_name.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomCartList extends StatelessWidget {
  CustomCartList({super.key});
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SpacerWidget(
          height: 3,
        ),
        Container(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            children: List.generate(
              controller.shopItemsMap.length,
              (index) {
                String shopName = controller.shopItemsMap.keys.elementAt(index);
                controller.products.value = controller.shopItemsMap[shopName]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCartShopName(shopName: shopName),
                    const Divider(
                      height: 30,
                      thickness: .8,
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
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  spacing: 8,
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ConfirmationDialog(
                                            message:
                                                "Do you want to remove this product?",
                                            onCancel: () {
                                              Navigator.pop(context);
                                            },
                                            onConfirm: () async {
                                              Navigator.pop(context);

                                              if (await controller.deleteCart(
                                                  product.cartID!, shopName)) {
                                                if (controller.checkedItems
                                                    .containsKey(
                                                        product.cartID)) {
                                                  controller.selectedItems
                                                      .remove(product);
                                                  controller.selected[shopName]!
                                                      .remove(product);
                                                  if (controller
                                                      .selected[shopName]!
                                                      .isEmpty) {
                                                    controller.selected
                                                        .remove(shopName);
                                                  }
                                                  controller
                                                      .calculateTotalPrice();
                                                }
                                              }
                                            },
                                          );
                                        });
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.trash,
                                  label: "Delete",
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      activeColor: Colors.teal,
                                      shape: const CircleBorder(),
                                      value: controller.checkedItems
                                          .containsKey(product.cartID),
                                      onChanged: (_) {
                                        controller.toggleCheckbox(
                                            product, shopName);
                                      },
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  AppRoute.productProfile,
                                                  arguments: product.productID);
                                            },
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              height:
                                                  controller.size.value.height *
                                                      .09,
                                              width:
                                                  controller.size.value.width *
                                                      .2,
                                              imageUrl:
                                                  "${AppLink.productImage}${image}",
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.black26,
                                                highlightColor: Colors.white,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.black26,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  right: 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    productName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            color:
                                                                Colors.black45),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  variationName != ""
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      5),
                                                          decoration: const BoxDecoration(
                                                              color: Colors
                                                                  .black12,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                          child: Text(
                                                            "Variation: $variationName",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black87),
                                                          ),
                                                        )
                                                      : Text(""),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                              text: "₱$price",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline1!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .teal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                            const TextSpan(
                                                                text: " "),
                                                            const TextSpan(),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              if (quantity !=
                                                                  1) {
                                                                quantity--;
                                                                product.quantity =
                                                                    quantity
                                                                        .toString();
                                                                if (controller
                                                                    .checkedItems
                                                                    .containsKey(
                                                                        product
                                                                            .cartID)) {
                                                                  controller
                                                                      .isCalculated
                                                                      .value = false;
                                                                }

                                                                controller
                                                                    .update();
                                                                Future.delayed(
                                                                    Duration(
                                                                        seconds:
                                                                            1,
                                                                        milliseconds:
                                                                            5),
                                                                    () async {
                                                                  await controller.updateQuantity(
                                                                      product
                                                                          .cartID!,
                                                                      quantity
                                                                          .toString());

                                                                  if (controller
                                                                      .checkedItems
                                                                      .containsKey(
                                                                          product
                                                                              .cartID)) {
                                                                    controller
                                                                        .calculateTotalPrice();
                                                                  }
                                                                });
                                                              } else {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return ConfirmationDialog(
                                                                        message:
                                                                            "Do you want to remove this product?",
                                                                        onCancel:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        onConfirm:
                                                                            () async {
                                                                          Navigator.pop(
                                                                              context);

                                                                          if (await controller.deleteCart(
                                                                              product.cartID!,
                                                                              shopName)) {
                                                                            if (controller.checkedItems.containsKey(product.cartID)) {
                                                                              controller.selectedItems.remove(product);
                                                                              controller.selected[shopName]!.remove(product);
                                                                              if (controller.selected[shopName]!.isEmpty) {
                                                                                controller.selected.remove(shopName);
                                                                              }
                                                                              controller.calculateTotalPrice();
                                                                            }
                                                                          }
                                                                        },
                                                                      );
                                                                    });
                                                              }
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12),
                                                              ),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                              child: const Text(
                                                                '-',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: 30,
                                                            decoration:
                                                                const BoxDecoration(
                                                              border: Border(
                                                                top: BorderSide(
                                                                    color: Colors
                                                                        .black12),
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black12),
                                                              ),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        2),
                                                            child: Center(
                                                              child: Text(
                                                                quantity
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              quantity++;
                                                              product.quantity =
                                                                  quantity
                                                                      .toString();
                                                              controller
                                                                  .update();
                                                              if (controller
                                                                  .checkedItems
                                                                  .containsKey(
                                                                      product
                                                                          .cartID)) {
                                                                controller
                                                                    .isCalculated
                                                                    .value = false;
                                                              }
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          1,
                                                                      milliseconds:
                                                                          5),
                                                                  () async {
                                                                await controller
                                                                    .updateQuantity(
                                                                        product
                                                                            .cartID!,
                                                                        quantity
                                                                            .toString());

                                                                if (controller
                                                                    .checkedItems
                                                                    .containsKey(
                                                                        product
                                                                            .cartID)) {
                                                                  controller
                                                                      .calculateTotalPrice();
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .black12),
                                                              ),
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 2),
                                                              child: const Text(
                                                                '+',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SpacerWidget(),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
