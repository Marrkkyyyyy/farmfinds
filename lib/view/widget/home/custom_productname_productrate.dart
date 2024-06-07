import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductNameProductRate extends StatelessWidget {
  CustomProductNameProductRate({super.key});
  final controller = Get.find<ProductProfileController>();

  @override
  Widget build(BuildContext context) {
    return controller.statusRequest == StatusRequest.success
        ? Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "₱${controller.product.price}",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.teal.shade600),
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  "${controller.product.productName}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: controller.totalRate.value,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                    ),
                    Container(
                      width: 1,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.black26,
                    ),
                    Text(
                      "${controller.totalSold.value} Sold",
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    baseColor: Color.fromARGB(90, 0, 0, 0),
                    highlightColor: Color.fromARGB(176, 255, 255, 255),
                    child: ClipRRect(
                      child: Container(
                        color: Color.fromARGB(90, 0, 0, 0),
                        height: 13,
                        width: controller.size.value.width * .3,
                      ),
                    )),
                SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                    baseColor: Color.fromARGB(90, 0, 0, 0),
                    highlightColor: Color.fromARGB(176, 255, 255, 255),
                    child: ClipRRect(
                      child: Container(
                        color: Color.fromARGB(90, 0, 0, 0),
                        height: 13,
                        width: controller.size.value.width * .9,
                      ),
                    )),
                SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                    baseColor: Color.fromARGB(90, 0, 0, 0),
                    highlightColor: Color.fromARGB(176, 255, 255, 255),
                    child: ClipRRect(
                      child: Container(
                        color: Color.fromARGB(90, 0, 0, 0),
                        height: 13,
                        width: controller.size.value.width * .6,
                      ),
                    )),
              ],
            ),
          );
  }
}
