import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/controller/shop/product_status/product_status_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../link_api.dart';
import '../../../widget/confirmation_dialog.dart';
import '../../../widget/spacer_widget.dart';

class DelistedProducts extends StatelessWidget {
  DelistedProducts({super.key});
  final controller = Get.find<ProductStatusController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.refreshData(),
      child: GetBuilder<ProductStatusController>(builder: (controller) {
        return HandlingDataRequest(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
                itemCount: controller.delistedProducts.length,
                itemBuilder: ((context, index) {
                  ShopProductItem product = controller.delistedProducts[index];
                  controller.imageUrls = product.imageURL!.split(',');
                  return Column(children: [
                    Container(
                      color: Colors.white,
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: controller.size.value.height * .1,
                                width: controller.size.value.width * .21,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: Colors.black12,
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.productProfile,
                                            arguments: controller
                                                .delistedProducts[index]);
                                      },
                                      child: CachedNetworkImage(
                                        fit: BoxFit.contain,
                                        imageUrl: AppLink.productImage +
                                            controller.imageUrls[0],
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productName!,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.manrope(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        NumberFormat.currency(
                                          locale: 'en_PH',
                                          symbol: '₱',
                                          decimalDigits: 0,
                                        ).format(int.parse(product.price!)),
                                        style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 14,
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.sell,
                                        size: 14.0,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Sold 8 ',
                                        style: GoogleFonts.manrope(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.eye,
                                        size: 14.0,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        'Views 0 ',
                                        style: GoogleFonts.manrope(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ConfirmationDialog(
                                          message:
                                              "Are you sure publish the product?",
                                          onCancel: () {
                                            Navigator.pop(context);
                                          },
                                          onConfirm: () {
                                            Navigator.pop(context);
                                            controller.publishProduct(
                                                product.productID!);
                                          },
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(3)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          controller.size.value.width * .15,
                                      vertical: 6),
                                  child: Text(
                                    "Publish",
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black26),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        controller.size.value.width * .15,
                                    vertical: 6),
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                color: Colors.transparent,
                                                width:
                                                    controller.size.value.width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Center(
                                                  child: Text(
                                                    "Price & Stock",
                                                    style: GoogleFonts.manrope(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              height: 0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ConfirmationDialog(
                                                          message:
                                                              "Are you sure delete the product?",
                                                          onCancel: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          onConfirm: () async {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                    });
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                width:
                                                    controller.size.value.width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                child: Center(
                                                  child: Text(
                                                    "Delete",
                                                    style: GoogleFonts.manrope(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SpacerWidget(),
                                            Container(
                                              color: Colors.transparent,
                                              width:
                                                  controller.size.value.width,
                                              padding: const EdgeInsets.only(
                                                  top: 14, bottom: 22),
                                              child: Center(
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.manrope(
                                                    fontSize: 14,
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(3)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 6),
                                  child: Text(
                                    "...",
                                    style: GoogleFonts.manrope(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    const SpacerWidget()
                  ]);
                })));
      }),
    );
  }
}
