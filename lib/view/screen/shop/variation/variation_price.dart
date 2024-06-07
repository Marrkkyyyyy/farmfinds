import 'package:ecommerce/controller/shop/product/variation_controller.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_variation_textfield.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_variation_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class VariationPrice extends StatelessWidget {
  VariationPrice({super.key});
  final controller = Get.put(VariationController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(left: 8.0),
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.teal,
                    size: 20,
                  ),
                )),
            leadingWidth: 40,
            title: const Text(
              "Set Price",
            ),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: controller.formstate,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      color: Colors.blueGrey.shade200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomVariationTitle(
                            text: "Variations",
                            textStyle: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.black),
                          ),
                          CustomVariationTitle(
                            text: "Price",
                            textStyle: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 12,
                        right: 8,
                      ),
                      child: Column(
                        children: List.generate(
                            controller.variationPrice.length, (index) {
                          final variationNames =
                              controller.variationPrice.keys.toList()
                                ..sort((a, b) {
                                  final aNumeric =
                                      int.tryParse(a.split(' ')[0]) ?? 0;
                                  final bNumeric =
                                      int.tryParse(b.split(' ')[0]) ?? 0;
                                  return aNumeric.compareTo(bNumeric);
                                });
                          final unitVariation = variationNames[index];
                          final textController =
                              controller.variationPrice[unitVariation];
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomVariationTitle(
                                  text: unitVariation.toString(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.black54),
                                ),
                                CustomVariationTextfield(
                                    controller: textController),
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white,
            child: TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * .8, 47),
                  backgroundColor: const Color.fromARGB(255, 31, 129, 121),
                  shape: const RoundedRectangleBorder()),
              child: Text(
                "SAVE",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
              onPressed: () async {
                controller.validatePrice();
              },
            ),
          )),
    );
  }
}
