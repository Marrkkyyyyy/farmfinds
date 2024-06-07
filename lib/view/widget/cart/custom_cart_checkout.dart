import 'package:ecommerce/controller/cart/cart_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/view/widget/show_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCartCheckOut extends StatelessWidget {
  CustomCartCheckOut({super.key});
  final controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w600),
                        text: '',
                        children: [
                      const TextSpan(
                          text: "₱",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          )),
                      const TextSpan(text: ""),
                      TextSpan(
                          text: controller.total.value.toString(),
                          style: const TextStyle(
                              color: Colors.black54, fontSize: 16)),
                    ]));
              }),
              const SizedBox(
                width: 5,
              ),
              Obx(() {
                return TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      fixedSize: Size(controller.size.value.width * .3, 47),
                      backgroundColor: controller.selected.isEmpty
                          ? Color.fromARGB(75, 0, 0, 0)
                          : const Color.fromARGB(255, 31, 129, 121),
                      shape: const RoundedRectangleBorder()),
                  child: controller.isCalculated.value
                      ? Text(
                          "CHECKOUT",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color: controller.selected.isEmpty
                                      ? Colors.black38
                                      : Colors.white),
                        )
                      : CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 1,
                        ),
                  onPressed: controller.isCalculated.value
                      ? () async {
                          if (!controller.selected.isEmpty) {
                            Get.toNamed(AppRoute.placeOrder, arguments: {
                              "total": controller.total.value,
                              "item": controller.selected
                            });
                          } else {
                            showErrorMessage(
                                "Please select items to proceed with the checkout");
                          }
                        }
                      : () {},
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
