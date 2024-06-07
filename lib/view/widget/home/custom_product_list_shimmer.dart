import 'package:ecommerce/controller/home/product_list_controller.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_image_home.dart';
import 'package:ecommerce/view/widget/home/custom_shop_image_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductListShimmer extends StatelessWidget {
  CustomProductListShimmer({super.key});
  final controller = Get.find<ProductListController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomImageHome(
            size: controller.size.value,
            image: CustomShopImageHome(
              heroTag: controller.shops.profile!,
              image: "${AppLink.shopImage}${controller.shops.profile}",
            )),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Color.fromARGB(80, 0, 0, 0),
                  highlightColor: Color.fromARGB(106, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(80, 0, 0, 0),
                      height: 14,
                      width: controller.size.value.width * .4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Color.fromARGB(80, 0, 0, 0),
                  highlightColor: Color.fromARGB(106, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(80, 0, 0, 0),
                      height: 14,
                      width: controller.size.value.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Color.fromARGB(80, 0, 0, 0),
                  highlightColor: Color.fromARGB(106, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(80, 0, 0, 0),
                      height: 14,
                      width: controller.size.value.width,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Color.fromARGB(80, 0, 0, 0),
                      highlightColor: Color.fromARGB(106, 255, 255, 255),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Container(
                          color: Color.fromARGB(80, 0, 0, 0),
                          height: 14,
                          width: controller.size.value.width * .27,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Shimmer.fromColors(
                      baseColor: Color.fromARGB(80, 0, 0, 0),
                      highlightColor: Color.fromARGB(106, 255, 255, 255),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Container(
                          color: Color.fromARGB(80, 0, 0, 0),
                          height: 14,
                          width: controller.size.value.width * .2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Color.fromARGB(80, 0, 0, 0),
                  highlightColor: Color.fromARGB(106, 255, 255, 255),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    child: Container(
                      color: Color.fromARGB(80, 0, 0, 0),
                      height: 14,
                      width: controller.size.value.width * .32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
