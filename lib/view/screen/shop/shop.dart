import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/shop/shop/shop_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_product_display.dart';
import 'package:ecommerce/view/widget/home/custom_product_shimmer.dart';
import 'package:ecommerce/view/widget/shop/custom_order_transaction_button.dart';
import 'package:ecommerce/view/widget/shop/custom_shop_edit_button.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:ecommerce/view/widget/user/custom_name_user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ShopPage extends StatelessWidget {
  ShopPage({Key? key}) : super(key: key);
  final controller = Get.put(ShopController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(4, 0, 0, 0),
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
          elevation: 2,
          leadingWidth: 34,
          title: const Text(
            "My Shop",
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => await controller.refreshShopProducts(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GetBuilder<ShopController>(builder: (controller) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Stack(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: controller.size.value.width,
                            child: Row(children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    ClipOval(
                                      child: SizedBox(
                                          height: controller.size.value.height *
                                              0.07,
                                          width: controller.size.value.width *
                                              0.15,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${AppLink.shopImage}${controller.profile}",
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height:
                                                controller.size.value.height *
                                                    0.4,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.black26,
                                              highlightColor: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black26,
                                              ),
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: CustomName(
                                        textColor: Colors.blueGrey,
                                        name: controller.shopName!,
                                        size: controller.size.value,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomShopEditButton(
                                  function: () {
                                    Get.toNamed(AppRoute.editShop);
                                  },
                                  text: "Edit")
                            ]),
                          ),
                        ]),
                      ),
                      const SpacerWidget(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomOrderTransactionButton(
                                size: controller.size.value,
                                text: "Processing",
                                totalTransaction:
                                    controller.totalProcessing.value,
                                function: () {
                                  Get.toNamed(AppRoute.shopOrder,
                                      arguments: {'initialIndex': 0});
                                }),
                            CustomOrderTransactionButton(
                                size: controller.size.value,
                                text: "Shipped",
                                totalTransaction: controller.totalShipped.value,
                                function: () {
                                  Get.toNamed(AppRoute.shopOrder,
                                      arguments: {'initialIndex': 1});
                                }),
                            CustomOrderTransactionButton(
                                size: controller.size.value,
                                text: "Completed",
                                totalTransaction:
                                    controller.totalCompleted.value,
                                function: () {
                                  Get.toNamed(AppRoute.shopOrder,
                                      arguments: {'initialIndex': 2});
                                }),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              GetBuilder<ShopController>(builder: (controller) {
                return controller.statusRequest == StatusRequest.loading
                    ? SliverGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        childAspectRatio: 0.75,
                        children: List.generate(
                          6,
                          (index) {
                            return CustomProductShimmer(
                                size: controller.size.value);
                          },
                        ))
                    : controller.statusRequest == StatusRequest.offlinefailure
                        ? SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Lottie.asset(
                                  AppImageASset.offline,
                                  height: 250,
                                  width: 250,
                                ),
                              ],
                            ),
                          )
                        : controller.statusRequest ==
                                StatusRequest.serverfailure
                            ? SliverToBoxAdapter(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50,
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
                                        child: Lottie.asset(
                                            AppImageASset.server,
                                            width: 250,
                                            height: 250),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : controller.liveProducts.isNotEmpty
                                ? SliverGrid.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    childAspectRatio: 0.75,
                                    children: List.generate(
                                      controller.liveProducts.length,
                                      (index) {
                                        return CustomProductDisplay(
                                            image: controller
                                                .liveProducts[index].imageURL!
                                                .split(","),
                                            size: controller.size.value,
                                            product:
                                                controller.liveProducts[index]);
                                      },
                                    ),
                                  )
                                : SliverToBoxAdapter(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                            child: SizedBox(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: controller
                                                        .size.value.height *
                                                    .2,
                                              ),
                                              const FaIcon(
                                                FontAwesomeIcons.handshake,
                                                size: 80,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "Start selling on FarmFinds",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1!
                                                    .copyWith(
                                                        color: Colors.black54),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  fixedSize: Size(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .6,
                                                      45),
                                                  shape:
                                                      const RoundedRectangleBorder(),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 31, 129, 121),
                                                ),
                                                onPressed: () async {
                                                  Get.toNamed(
                                                      AppRoute.addProduct);
                                                },
                                                child: Text(
                                                  "Add Products",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5!
                                                      .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                      ],
                                    ),
                                  );
              })
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          return controller.shopProducts.isEmpty
              ? SizedBox()
              : Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * .8, 47),
                      shape: const RoundedRectangleBorder(),
                      backgroundColor: const Color.fromARGB(255, 31, 129, 121),
                    ),
                    onPressed: () async {
                      Get.toNamed(AppRoute.shopProductStatus);
                    },
                    child: Text(
                      "View Products Status",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                );
        }));
  }
}
