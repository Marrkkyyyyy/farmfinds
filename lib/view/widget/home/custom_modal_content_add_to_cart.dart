import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomModalContentAddToCart extends StatelessWidget {
  CustomModalContentAddToCart({super.key});
  final controller = Get.find<ProductProfileController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 12, right: 12, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: controller.size.value.height * .13,
                width: controller.size.value.width * .25,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: "${AppLink.productImage}${controller.image[0]}",
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Color.fromARGB(50, 0, 0, 0),
                      highlightColor: Color.fromARGB(176, 255, 255, 255),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        child: Container(
                          color: Color.fromARGB(50, 0, 0, 0),
                          height: controller.size.value.height * .13,
                          width: controller.size.value.width * .25,
                        ),
                      )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Obx(() {
                return Text(
                    "₱${controller.variationPrices[controller.selectedIndex.value]}",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        color: Colors.teal,
                        fontWeight: FontWeight.w300));
              }),
            ],
          ),
          const Divider(
            height: 30,
          ),
          Text("Variation", style: Theme.of(context).textTheme.bodyText1),
          Wrap(
              children: List.generate(
            controller.variationNames.length,
            (index) => GestureDetector(
              onTap: () {
                controller.selectedVariation(index);
              },
              child: Obx(() {
                return Container(
                  margin: const EdgeInsets.only(right: 10, top: 10, bottom: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.selectedIndex.value == index
                              ? Colors.teal
                              : Colors.transparent),
                      color: const Color.fromARGB(10, 0, 0, 0)),
                  child: Text(controller.variationNames[index],
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500)),
                );
              }),
            ),
          )),
          const Divider(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Quantity",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w300)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (controller.quantityCount.value > 1) {
                        controller.quantityCount.value--; // Decrement count
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text(
                        '-',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black12),
                        bottom: BorderSide(color: Colors.black12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Center(child: Obx(() {
                      return Text(
                        controller.quantityCount.value.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16, color: Colors.black54),
                      );
                    })),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.quantityCount.value++;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text(
                        '+',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 30,
          ),
          TextButton(
            style: TextButton.styleFrom(
                fixedSize: Size(controller.size.value.width * 1, 47),
                backgroundColor: const Color.fromARGB(255, 31, 129, 121),
                shape: const RoundedRectangleBorder()),
            onPressed: () async {
              if (controller.userID == null) {
                Get.toNamed(AppRoute.login);
              } else {
                controller.addToCart();
              }
            },
            child: Text(
              "ADD TO CART",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
