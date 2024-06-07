import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/shop_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_home_address.dart';
import 'package:ecommerce/view/widget/home/custom_home_rating.dart';
import 'package:ecommerce/view/widget/home/custom_home_rating_text.dart';
import 'package:ecommerce/view/widget/home/custom_home_shop_name.dart';
import 'package:ecommerce/view/widget/home/custom_icon_angle_right.dart';
import 'package:ecommerce/view/widget/home/custom_image_home.dart';
import 'package:ecommerce/view/widget/home/custom_shop_image_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomShopDisplay extends StatelessWidget {
  final Size size;
  final List<ShopModel> shops;
  const CustomShopDisplay({super.key, required this.size, required this.shops});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: shops.length,
            (BuildContext context, int index) {
      RxDouble totalShopRate = 0.0.obs;
      if (double.parse(shops[index].totalRows!) == 0) {
        totalShopRate.value = 0.0;
      } else {
        totalShopRate.value = double.parse(
          (double.parse(shops[index].totalRating!) /
                  double.parse(shops[index].totalRows!))
              .toStringAsFixed(1),
        );
      }
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.productItemList, arguments: shops[index]);
            },
            child: Container(
              color: Colors.transparent,
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
              child: SizedBox(
                height: size.height * .15,
                width: size.width,
                child: Row(children: [
                  CustomImageHome(
                      size: size,
                      image: CustomShopImageHome(
                        heroTag: shops[index].profile!,
                        image: "${AppLink.shopImage}${shops[index].profile}",
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomHomeShopName(text: shops[index].shopName!),
                              CustomHomeAddress(
                                  maxLines: 2,
                                  address:
                                      "${shops[index].streetName!}, ${shops[index].barangay!}, ${shops[index].province!}, ${shops[index].postalCode!}")
                            ],
                          ),
                          CustomHomeRating(
                              rate: totalShopRate.value,
                              rateText: CustomHomeRatingText(
                                rateText: "$totalShopRate",
                              ))
                        ],
                      ),
                    ),
                  ),
                  const CustomIconAngleRight()
                ]),
              ),
            ),
          ),
          const Divider(
            height: 6,
            thickness: 1,
          )
        ],
      );
    }));
  }
}
