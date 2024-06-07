import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/home/custom_modal_content_add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductAddToCart extends StatelessWidget {
  CustomProductAddToCart({super.key});

  final controller = Get.find<ProductProfileController>();
  @override
  Widget build(BuildContext context) {
    return controller.statusRequest == StatusRequest.loading
        ? SizedBox()
        : Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  fixedSize: Size(controller.size.value.width * 1, 47),
                  backgroundColor: const Color.fromARGB(255, 31, 129, 121),
                  shape: const RoundedRectangleBorder()),
              onPressed: controller.variationIDs.isEmpty ||
                      controller.variationIDs[0] == "null"
                  ? () {
                      if (controller.userID == null) {
                        Get.toNamed(AppRoute.login);
                      } else {
                        controller.addToCart();
                      }
                    }
                  : () {
                      showCustomProductAddToCartModal(context);
                    },
              child: Text(
                "ADD TO CART",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ));
  }

  showCustomProductAddToCartModal(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return CustomModalContentAddToCart();
      },
    );
  }
}
