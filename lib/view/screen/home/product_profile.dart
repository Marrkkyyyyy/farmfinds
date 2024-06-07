import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/view/widget/home/custom_description_expandable.dart';
import 'package:ecommerce/view/widget/home/custom_product_add_to_cart.dart';
import 'package:ecommerce/view/widget/home/custom_product_preview.dart';
import 'package:ecommerce/view/widget/home/custom_product_sliver_appbar.dart';
import 'package:ecommerce/view/widget/home/custom_productname_productrate.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductProfile extends StatelessWidget {
  ProductProfile({Key? key}) : super(key: key);
  final controller = Get.put(ProductProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductProfileController>(
          init: ProductProfileController(),
          initState: (a) {
            controller.productID = Get.arguments;
            controller.fetchProductReviews(controller.productID);
          },
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async => await controller.refreshData(),
              child: CustomScrollView(
                slivers: [
                  CustomProductSliverAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      const SpacerWidget(),
                      CustomProductNameProductRate(),
                      const SpacerWidget(),
                      CustomDescriptionExpandable(),
                      const SpacerWidget(),
                      CustomProductPreview(),
                    ]),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar:
          GetBuilder<ProductProfileController>(builder: (controller) {
        return controller.statusRequest != StatusRequest.success
            ? SizedBox()
            : controller.product.shopID == controller.shopID
                ? SizedBox()
                : CustomProductAddToCart();
      }),
    );
  }
}
