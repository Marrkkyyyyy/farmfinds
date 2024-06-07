import 'package:ecommerce/controller/shop/product/variation_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_divider.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_list_variation.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_variation_checkbox.dart';
import 'package:ecommerce/view/widget/shop/product/variation/custom_variation_unit.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddVariation extends StatelessWidget {
  AddVariation({super.key});

  final controller = Get.put(VariationController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          if (controller.selectedVariation.isEmpty) {
            Get.back();
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    message:
                        "Do you want to discard variation? Selected variation will not be saved",
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      Navigator.pop(context);
                      controller.resetData();
                      Get.back();
                    },
                  );
                });
          }
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    if (controller.selectedVariation.isEmpty) {
                      Get.back();
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmationDialog(
                              message:
                                  "Do you want to discard variation? Selected variation will not be saved",
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () {
                                Navigator.pop(context);
                                controller.resetData();
                                Get.back();
                              },
                            );
                          });
                    }
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.teal,
                      size: 20,
                    ),
                  )),
              elevation: 2,
              leadingWidth: 34,
              title: const Text(
                "Add Variation",
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    controller.resetData();
                    controller.update();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "Reset",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                )
              ],
            ),
            body: GetBuilder<VariationController>(builder: (controller) {
              return controller.statusRequest == StatusRequest.loading
                  ? Center(
                      child: Lottie.asset(AppImageASset.loading,
                          width: 250, height: 250),
                    )
                  : controller.statusRequest == StatusRequest.offlinefailure
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                controller.refreshVariation();
                              },
                              child: Text(
                                "Reload Page",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                              style: TextButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * .34,
                                    35),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor:
                                    Color.fromARGB(123, 0, 150, 135),
                              ),
                            ),
                            Center(
                              child: Lottie.asset(AppImageASset.offline,
                                  width: 250, height: 250),
                            ),
                          ],
                        )
                      : controller.statusRequest == StatusRequest.serverfailure
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    controller.refreshVariation();
                                  },
                                  child: Text(
                                    "Reload Page",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(
                                        MediaQuery.of(context).size.width * .34,
                                        35),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    backgroundColor:
                                        Color.fromARGB(123, 0, 150, 135),
                                  ),
                                ),
                                Center(
                                  child: Lottie.asset(AppImageASset.server,
                                      width: 250, height: 250),
                                ),
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(children: [
                                const SpacerWidget(),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.unitVariations.length,
                                  itemBuilder: (context, unitIndex) {
                                    final unitName = controller
                                        .unitVariations.keys
                                        .toList()[unitIndex];
                                    final unit = unitName[0].toUpperCase() +
                                        unitName.substring(1);
                                    final unitVariations =
                                        controller.unitVariations[unitName];
                                    return Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, left: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomVariationUnit(text: unit),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const CustomDivider(),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: unitVariations!.length,
                                            itemBuilder: (context, index) {
                                              final variation =
                                                  unitVariations[index];
                                              return Column(
                                                children: [
                                                  ListTile(
                                                    dense: true,
                                                    title: CustomListVariation(
                                                        text:
                                                            "${variation['value']} ${variation['units']}"),
                                                    trailing:
                                                        CustomVariationCheckbox(
                                                            val: controller
                                                                .selectedVariation
                                                                .contains(variation[
                                                                        'variationID']
                                                                    .toString()),
                                                            onChanged: (val) {
                                                              controller
                                                                  .onChangedCheckbox(
                                                                      val!,
                                                                      variation);
                                                              return null;
                                                            }),
                                                  ),
                                                  const CustomDivider(),
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              ]),
                            );
            }),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * .8, 47),
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.validateVariation();
                  },
                  child: Text(
                    "Next: Set Price",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.teal,
                          fontSize: 16,
                          letterSpacing: .8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ))),
      ),
    );
  }
}
