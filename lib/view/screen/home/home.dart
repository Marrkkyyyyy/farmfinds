import 'package:ecommerce/controller/home/shop_controller.dart';
import 'package:ecommerce/core/class/handling_sliver_data_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/home/custom_shop_display.dart';
import 'package:ecommerce/view/widget/home/custom_shop_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  final Size size;
  Home({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopHomeController());
    return RefreshIndicator(
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
            expandedHeight: size.height * 0.06,
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
          GetBuilder<ShopHomeController>(builder: (controller) {
            return HandlingSliverDataRequest(
                statusRequest: controller.statusRequest,
                widget: CustomShopDisplay(
                  size: size,
                  shops: controller.shops,
                ),
                shimmer: CustomShopShimmer(size: size));
          })
        ],
      ),
    );
  }
}
