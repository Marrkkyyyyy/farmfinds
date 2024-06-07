import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductSliverAppBar extends StatelessWidget {
  CustomProductSliverAppBar({super.key});
  final controller = Get.find<ProductProfileController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
        )),
        expandedHeight: controller.size.value.height * .45,
        floating: false,
        pinned: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.2),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (controller.userID == null) {
                Get.toNamed(AppRoute.login);
              } else {
                Get.toNamed(AppRoute.cartPage);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.2),
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.white,
                    size: 19,
                  ),
                ),
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 1,
        flexibleSpace: controller.statusRequest == StatusRequest.success
            ? FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: [
                    PageView.builder(
                      itemCount: controller.image.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl:
                              "${AppLink.productImage}${controller.image[index]}",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Color.fromARGB(60, 0, 0, 0),
                            highlightColor: Color.fromARGB(176, 255, 255, 255),
                            child: Container(
                              color: Color.fromARGB(60, 0, 0, 0),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      },
                      onPageChanged: (index) {
                        controller.indexImage.value = index;
                      },
                      controller: PageController(
                        initialPage: controller.indexImage.value,
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      right: 12,
                      child: Obx(() {
                        return Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(181, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 2),
                          child: Text(
                            '${controller.indexImage.value + 1}/${controller.image.length}',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black87),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              )
            : Shimmer.fromColors(
                baseColor: Color.fromARGB(48, 0, 0, 0),
                highlightColor: Colors.white,
                child: Container(
                  color: Color.fromARGB(48, 0, 0, 0),
                ),
              ));
  }
}
