import 'package:ecommerce/controller/scan/scanner_controller.dart';
import 'package:ecommerce/core/class/handling_scan_vegetable.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/view/screen/scanner/search_vegetable.dart';
import 'package:ecommerce/view/widget/scanner/custom_button_capture.dart';
import 'package:ecommerce/view/widget/scanner/custom_tips_image.dart';
import 'package:ecommerce/view/widget/scanner/custom_tips_perfect_image.dart';
import 'package:ecommerce/view/widget/scanner/custom_tips_title.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Scanner extends StatelessWidget {
  Scanner({super.key});
  final controller = Get.put(ScannerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 8.0),
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                color: Colors.teal,
                size: 25,
              ),
            )),
        elevation: 0,
        leadingWidth: 34,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchVegetable());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.teal,
                size: 30,
              ))
        ],
      ),
      body: GetBuilder<ScannerController>(builder: (controller) {
        return HandlingScanVegetable(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(16, 0, 0, 0),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(children: [
                      const FaIcon(
                        FontAwesomeIcons.circleQuestion,
                        size: 28,
                        color: Colors.black87,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomTipsTitle(text: "Snap Tips"),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTipsPerfectImage(
                        image: AppImageASset.perfect,
                        size: controller.size.value,
                      ),
                      const Divider(
                        height: 20,
                        color: Colors.black54,
                        thickness: 1.5,
                      ),
                      Text(
                        "The following will lead to poor results",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTipsImage(
                            image: AppImageASset.tooFar,
                            text: "too far",
                            size: controller.size.value,
                          ),
                          CustomTipsImage(
                            image: AppImageASset.tooClose,
                            text: "too close",
                            size: controller.size.value,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTipsImage(
                            image: AppImageASset.blurr,
                            text: "Blurry",
                            size: controller.size.value,
                          ),
                          CustomTipsImage(
                            image: AppImageASset.multipleSpecies,
                            text: "Multiple species",
                            size: controller.size.value,
                          ),
                        ],
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButtonCapture(
                          function: () {
                            controller.pickImage();
                          },
                          iconData: FontAwesomeIcons.solidImage,
                          text: "Photos"),
                      CustomButtonCapture(
                          function: () {
                            controller.camera();
                          },
                          iconData: FontAwesomeIcons.camera,
                          text: "Camera"),
                    ],
                  )
                ],
              ),
            ));
      }),
    );
  }
}
