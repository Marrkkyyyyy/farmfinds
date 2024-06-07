import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductDisplay extends StatelessWidget {
  final Size size;
  final ShopProductItem product;
  final List<String> image;
  const CustomProductDisplay(
      {super.key,
      required this.size,
      required this.product,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.productProfile, arguments: product.productID);
      },
      child: Card(
        color: const Color.fromARGB(255, 252, 252, 252),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        elevation: 2,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * .195,
              child: Center(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: "${AppLink.productImage}${image[0]}",
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Color.fromARGB(50, 0, 0, 0),
                    highlightColor: Color.fromARGB(176, 255, 255, 255),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: Container(
                        color: Color.fromARGB(50, 0, 0, 0),
                        height: size.height * .195,
                        width: size.width * 1,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: size.height * .2, left: 8, right: 7),
              child: Text(
                "${product.productName!}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: const Color.fromARGB(221, 0, 0, 0),
                    ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 7, bottom: 10),
                  child: Text("₱${product.price!}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 15,
                            color: Colors.teal.shade600,
                            fontWeight: FontWeight.w700,
                          ))),
            ),
          ],
        ),
      ),
    );
  }
}
