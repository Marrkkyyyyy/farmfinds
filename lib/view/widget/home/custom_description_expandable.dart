import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomDescriptionExpandable extends StatelessWidget {
  CustomDescriptionExpandable({super.key});
  final controller = Get.find<ProductProfileController>();
  @override
  Widget build(BuildContext context) {
    return controller.statusRequest == StatusRequest.success
        ? Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                  ),
                  child: Text(
                    "Description",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    controller.product.productDescription!,
                    maxLines: controller.isExpanded.value ? 1000 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          height: 1.5,
                          fontSize: 16,
                        ),
                  ),
                ),
                if (controller.product.productDescription!.split('\n').length >
                    3)
                  GestureDetector(
                    onTap: controller.toggleExpansion,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Color.fromARGB(19, 0, 0, 0),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.isExpanded.value
                                ? "See Less"
                                : "See More",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.teal,
                                      fontSize: 16,
                                    ),
                          ),
                          controller.isExpanded.value
                              ? const Icon(Icons.keyboard_arrow_up_rounded)
                              : const Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                  )
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
                        width: controller.size.value.width * .6,
                      ),
                    )),
              ],
            ),
          );
  }
}
