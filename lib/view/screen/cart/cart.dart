import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_appbar.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:ecommerce/controller/cart/cart_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/view/widget/cart/custom_cart_checkout.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchShops();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.teal,
                    size: 20,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 2,
              foregroundColor: Colors.black,
              leadingWidth: 34,
              title: Obx(() {
                return RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.teal),
                    text: '',
                    children: [
                      TextSpan(
                        text: "Cart",
                      ),
                      const TextSpan(text: " "),
                      TextSpan(
                        text: "(${controller.totalCart.value})",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.teal),
                      ),
                    ],
                  ),
                );
              }),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return controller.statusRequest == StatusRequest.loading
                      ? Column(
                          children: [
                            SizedBox(
                              height: controller.size.value.height * .25,
                            ),
                            Lottie.asset(AppImageASset.loading,
                                width: 250, height: 250),
                          ],
                        )
                      : controller.statusRequest == StatusRequest.serverfailure
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: controller.size.value.height * .25,
                                  ),
                                  Text(
                                    "Server failure. Please check your internet connection and refresh the page",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black54),
                                  ),
                                  Center(
                                    child: Lottie.asset(AppImageASset.server,
                                        width: 200, height: 200),
                                  ),
                                ],
                              ),
                            )
                          : controller.statusRequest ==
                                  StatusRequest.offlinefailure
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          controller.size.value.height * .25,
                                    ),
                                    Lottie.asset(AppImageASset.offline,
                                        width: 250, height: 250),
                                  ],
                                )
                              : controller.shopItemsMap.isEmpty
                                  ? CustomCartEmpty()
                                  : CustomCartList();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return controller.statusRequest == StatusRequest.offlinefailure
              ? SizedBox()
              : controller.statusRequest == StatusRequest.loading
                  ? SizedBox()
                  : controller.statusRequest == StatusRequest.failure
                      ? SizedBox()
                      : controller.statusRequest == StatusRequest.serverfailure
                          ? SizedBox()
                          : controller.shopItemsMap.isEmpty
                              ? SizedBox()
                              : CustomCartCheckOut();
        },
      ),
    );
  }
}
