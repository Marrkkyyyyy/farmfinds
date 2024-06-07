import 'package:ecommerce/controller/home/product_list_controller.dart';
import 'package:ecommerce/core/class/handling_sliver_data_request.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_home_address.dart';
import 'package:ecommerce/view/widget/home/custom_home_rating.dart';
import 'package:ecommerce/view/widget/home/custom_home_rating_text.dart';
import 'package:ecommerce/view/widget/home/custom_home_shop_name.dart';
import 'package:ecommerce/view/widget/home/custom_image_home.dart';
import 'package:ecommerce/view/widget/home/custom_product_display.dart';
import 'package:ecommerce/view/widget/home/custom_product_list_shimmer.dart';
import 'package:ecommerce/view/widget/home/custom_product_shimmer.dart';
import 'package:ecommerce/view/widget/home/custom_shop_image_home.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ProductItemList extends StatelessWidget {
  ProductItemList({super.key});
  final controller = Get.put(ProductListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await controller.refreshData(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                "FarmFinds",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black87),
              ),
              backgroundColor: Colors.white,
              floating: false,
              pinned: true,
              actions: [
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 18,
                  ),
                  onPressed: () {
                    if (controller.userID == null) {
                      Get.toNamed(AppRoute.login);
                    } else {
                      Get.toNamed(AppRoute.cartPage);
                    }
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: GetBuilder<ProductListController>(builder: (controller) {
                return Column(
                  children: [
                    controller.statusRequest == StatusRequest.loading
                        ? CustomProductListShimmer()
                        : Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 12, right: 12),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageHome(
                                      size: controller.size.value,
                                      image: CustomShopImageHome(
                                        heroTag: controller.shops.profile!,
                                        image:
                                            "${AppLink.shopImage}${controller.shops.profile}",
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomHomeShopName(
                                              text: controller.shops.shopName!),
                                          CustomHomeAddress(
                                              maxLines: 5,
                                              address:
                                                  "${controller.shops.streetName!}, ${controller.shops.barangay!}, ${controller.shops.province!}, ${controller.shops.postalCode!}"),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Obx(() {
                                            return CustomHomeRating(
                                                rate: controller
                                                    .totalShopRate.value,
                                                rateText: CustomHomeRatingText(
                                                  rateText:
                                                      "${controller.totalShopRate.value}",
                                                ));
                                          }),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Obx(() {
                                            return Text(
                                              "Products: ${controller.shopProducts.length}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5!
                                                  .copyWith(
                                                      color: Colors.black54),
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                    const SpacerWidget(
                      height: 7,
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                );
              }),
            ),
            GetBuilder<ProductListController>(builder: (controller) {
              return HandlingSliverDataRequest(
                  statusRequest: controller.statusRequest,
                  widget: controller.shopProducts.isEmpty
                      ? SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: controller.size.value.height * .1,
                              ),
                              Lottie.asset(AppImageASset.noProduct,
                                  width: 200, height: 200),
                              Text(
                                "No products available",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(color: Colors.black87),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Currently no products available in this shop",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      : SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          childAspectRatio: 0.75,
                          children: List.generate(
                            controller.shopProducts.length,
                            (index) {
                              List<String> images = controller
                                  .shopProducts[index].imageURL!
                                  .split(",");
                              return CustomProductDisplay(
                                  size: controller.size.value,
                                  product: controller.shopProducts[index],
                                  image: images);
                            },
                          ),
                        ),
                  shimmer: SliverGrid.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.75,
                      children: List.generate(
                        6,
                        (index) {
                          return CustomProductShimmer(
                              size: controller.size.value);
                        },
                      )));
            })
          ],
        ),
      ),
    );
  }
}
