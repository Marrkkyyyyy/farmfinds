import 'package:ecommerce/controller/shop/product/product_controller.dart';
import 'package:ecommerce/controller/shop/product/variation_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/core/functions/valid_input.dart';
import 'package:ecommerce/view/widget/confirmation_dialog.dart';
import 'package:ecommerce/view/widget/shop/product/custom_count_character.dart';
import 'package:ecommerce/view/widget/shop/product/custom_icon_textfield.dart';
import 'package:ecommerce/view/widget/shop/product/custom_photo_list_tile.dart';
import 'package:ecommerce/view/widget/shop/product/custom_picked_image.dart';
import 'package:ecommerce/view/widget/shop/product/custom_price_textfield.dart';
import 'package:ecommerce/view/widget/shop/product/custom_product_textfield.dart';
import 'package:ecommerce/view/widget/shop/product/custom_textfield_required_sign.dart';
import 'package:ecommerce/view/widget/shop/product/custom_title_textfield.dart';
import 'package:ecommerce/view/widget/shop/product/photo_bottom_sheet.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key) {
    variationController = Get.find<VariationController>();
  }
  late final VariationController variationController;
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          if (controller.selectedImages.isEmpty &&
              controller.productName.text.isEmpty &&
              controller.productDescription.text.isEmpty &&
              controller.price.text.isEmpty &&
              variationController.variationList.isEmpty) {
            Get.back();
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return ConfirmationDialog(
                    message: "Do you want to discard product?",
                    onCancel: () {
                      Navigator.pop(context);
                    },
                    onConfirm: () {
                      Navigator.pop(context);
                      Get.back();
                    },
                  );
                });
          }

          return true;
        },
        child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                      onPressed: () {
                        if (controller.selectedImages.isEmpty &&
                            controller.productName.text.isEmpty &&
                            controller.productDescription.text.isEmpty &&
                            controller.price.text.isEmpty &&
                            variationController.variationList.isEmpty) {
                          Get.back();
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return ConfirmationDialog(
                                  message: "Do you want to discard product?",
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  onConfirm: () {
                                    Navigator.pop(context);
                                    Get.back();
                                  },
                                );
                              });
                        }
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
                  leadingWidth: 34,
                  title: const Text(
                    "Add Product",
                  ),
                ),
                SliverToBoxAdapter(
                  child: GetBuilder<ProductController>(builder: (controller) {
                    return controller.statusRequest == StatusRequest.loading
                        ? Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .23,
                              ),
                              Center(
                                child: Lottie.asset(AppImageASset.loading,
                                    width: 250, height: 250),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SpacerWidget(),
                              const SizedBox(
                                height: 5,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: List.generate(
                                          controller.selectedImages.length,
                                          (index) {
                                            return CustomPickedImage(
                                                function: () {
                                                  customModalBottomSheet(
                                                    context,
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        CustomPhotoListTile(
                                                            icon:
                                                                FontAwesomeIcons
                                                                    .trash,
                                                            function: () {
                                                              controller
                                                                  .selectedImages
                                                                  .removeAt(
                                                                      index);
                                                              controller
                                                                  .update();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            text: "Remove")
                                                      ],
                                                    ),
                                                  );
                                                },
                                                widget: Image.file(
                                                  controller
                                                      .selectedImages[index]!,
                                                ));
                                          },
                                        ),
                                      ),
                                      CustomPickedImage(
                                          function: () {
                                            controller.pickImage();
                                          },
                                          widget: Center(
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const FaIcon(
                                                    FontAwesomeIcons.plus,
                                                    size: 9,
                                                    color: Colors.teal,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "Add Photo",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            color: Colors.teal),
                                                  )
                                                ]),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const SpacerWidget(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 12),
                                child: Form(
                                  key: controller.nameFormstate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              CustomTitleTextfield(
                                                  text: "Product Name"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CustomTextfieldRequiredSign()
                                            ],
                                          ),
                                          CustomCountCharacter(
                                            maxLength: "100",
                                            count:
                                                "${controller.nameCharacterCount.value}",
                                          )
                                        ],
                                      ),
                                      CustomProductTextfield(
                                          isDescription: false,
                                          maxLength: 100,
                                          valid: (val) {
                                            return validInput(
                                                val, "product_name");
                                          },
                                          onChanged: (_) {
                                            controller.updateCharacterCount();
                                            return null;
                                          },
                                          controller: controller.productName,
                                          hintText: "Enter Product Name"),
                                    ],
                                  ),
                                ),
                              ),
                              const SpacerWidget(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 12),
                                child: Form(
                                  key: controller.descriptionFormstate,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              CustomTitleTextfield(
                                                  text: "Product Description"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CustomTextfieldRequiredSign()
                                            ],
                                          ),
                                          CustomCountCharacter(
                                            maxLength: "3000",
                                            count:
                                                "${controller.descriptionCharacterCount.value}",
                                          )
                                        ],
                                      ),
                                      CustomProductTextfield(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          maxLength: 3000,
                                          valid: (val) {
                                            return validInput(
                                                val, "product_description");
                                          },
                                          onChanged: (_) {
                                            controller.updateCharacterCount();
                                            return null;
                                          },
                                          controller:
                                              controller.productDescription,
                                          hintText:
                                              "Enter Product Description"),
                                    ],
                                  ),
                                ),
                              ),
                              const SpacerWidget(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 5),
                                child: Column(children: [
                                  SizedBox(
                                    height: controller.size.value.height * .06,
                                    child: Row(
                                      children: [
                                        const CustomIconTextfield(
                                            icon: FontAwesomeIcons.tag),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const CustomTitleTextfield(
                                            text: "Price"),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const CustomTextfieldRequiredSign(),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CustomPriceTextfield(
                                          text: "Set",
                                          controller: controller.price,
                                          function: () {
                                            controller.price.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: controller
                                                      .price.text.length),
                                            );
                                          },
                                          onChanged: (value) {
                                            if (value!.isEmpty) return;
                                            final intValue =
                                                int.tryParse(value);
                                            if (intValue != null) {
                                              final formattedValue =
                                                  intValue.toString();
                                              controller.price.value =
                                                  TextEditingValue(
                                                text: formattedValue,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: formattedValue
                                                            .length),
                                              );
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      Get.toNamed(AppRoute.addVariation);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(right: 5),
                                      color: Colors.transparent,
                                      height:
                                          controller.size.value.height * .06,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: const [
                                                SizedBox(
                                                  width: 25,
                                                  child: Center(
                                                    child: CustomIconTextfield(
                                                        icon: FontAwesomeIcons
                                                            .chartBar),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                CustomTitleTextfield(
                                                    text: "Variations"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                            variationController
                                                    .variationList.isNotEmpty
                                                ? SizedBox(
                                                    width: controller
                                                            .size.value.width *
                                                        .4,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Row(
                                                          children:
                                                              variationController
                                                                  .units
                                                                  .take(2)
                                                                  .map((unit) {
                                                            return Row(
                                                              children: [
                                                                Text(
                                                                  unit,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline6!
                                                                      .copyWith(
                                                                        fontStyle:
                                                                            FontStyle.italic,
                                                                      ),
                                                                ),
                                                                if (variationController
                                                                            .units
                                                                            .length >
                                                                        1 &&
                                                                    unit !=
                                                                        variationController
                                                                            .units
                                                                            .elementAt(
                                                                                1))
                                                                  const Text(
                                                                      ", "),
                                                              ],
                                                            );
                                                          }).toList(),
                                                        ),
                                                        if (variationController
                                                                .units.length >
                                                            2)
                                                          Text(
                                                            "...",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6!
                                                                .copyWith(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic,
                                                                ),
                                                          ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        const FaIcon(
                                                            FontAwesomeIcons
                                                                .angleRight,
                                                            color:
                                                                Colors.black45,
                                                            size: 14)
                                                      ],
                                                    ),
                                                  )
                                                : const FaIcon(
                                                    FontAwesomeIcons.angleRight,
                                                    color: Colors.black45,
                                                    size: 14)
                                          ]),
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          );
                  }),
                )
              ],
            ),
            bottomNavigationBar:
                GetBuilder<ProductController>(builder: (controller) {
              return Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * .8, 47),
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: const Color.fromARGB(255, 31, 129, 121),
                  ),
                  onPressed:
                      controller.statusRequest == StatusRequest.loading ||
                              controller.statusRequest == StatusRequest.success
                          ? () {}
                          : () {
                              controller.productValidate();
                            },
                  child: Text(
                      controller.statusRequest == StatusRequest.loading
                          ? "PROCESSING"
                          : "PUBLISH",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white)),
                ),
              );
            })),
      ),
    );
  }
}
