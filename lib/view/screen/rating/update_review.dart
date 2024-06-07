import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce/controller/reviews/update_review_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/data/model/new/review_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/order/custom_button_order.dart';
import 'package:ecommerce/view/widget/shop/product/custom_photo_list_tile.dart';
import 'package:ecommerce/view/widget/shop/product/custom_picked_image.dart';
import 'package:ecommerce/view/widget/shop/product/photo_bottom_sheet.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UpdateReview extends StatelessWidget {
  UpdateReview({super.key});
  final controller = Get.put(UpdateReviewController());
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
              icon: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: FaIcon(
                  FontAwesomeIcons.arrowLeft,
                  color: Colors.teal,
                  size: 20,
                ),
              ),
            ),
            elevation: 2,
            leadingWidth: 34,
            title: Text("Rate Product"),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<UpdateReviewController>(builder: (controller) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: controller.size.value.height * .01,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.reviews.order.length,
                          itemBuilder: (context, index) {
                            ReviewItem review = controller.reviews.order[index];

                            return Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          "${AppLink.productImage}${review.productImageUrl}",
                                      fit: BoxFit.fill,
                                      height: 75,
                                      width: 75,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.black26,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          color: Colors.black26,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            review.productName!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          review.variationName == "null"
                                              ? SizedBox()
                                              : Text(
                                                  review.variationName!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 14),
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                  height: 20,
                                ),
                              ],
                            );
                          }),
                      Align(
                        alignment: Alignment.center,
                        child: RatingBar.builder(
                          initialRating: controller.rate.value.toDouble(),
                          minRating: 1,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 40.0,
                          direction: Axis.horizontal,
                          onRatingUpdate: (rating) {
                            controller.rate.value = rating.toInt();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                ...List.generate(
                                  controller.reviewImageUrl.isEmpty
                                      ? controller.selectedImages.length
                                      : controller.reviewImageUrl.length,
                                  (index) {
                                    return controller.reviewImageUrl.isEmpty
                                        ? CustomPickedImage(
                                            function: () {
                                              customModalBottomSheet(
                                                context,
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CustomPhotoListTile(
                                                        icon: FontAwesomeIcons
                                                            .trash,
                                                        function: () {
                                                          controller
                                                              .selectedImages
                                                              .removeAt(index);
                                                          controller.update();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        text: "Remove")
                                                  ],
                                                ),
                                              );
                                            },
                                            widget: Image.file(
                                              controller.selectedImages[index]!,
                                            ))
                                        : CustomPickedImage(
                                            function: () {
                                              customModalBottomSheet(
                                                context,
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CustomPhotoListTile(
                                                        icon: FontAwesomeIcons
                                                            .trash,
                                                        function: () {
                                                          controller
                                                              .removeImageURL
                                                              .add(controller
                                                                      .reviewImageUrl[
                                                                  index]);
                                                          controller
                                                              .reviewImageUrl
                                                              .removeAt(index);
                                                          controller.update();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        text: "Remove")
                                                  ],
                                                ),
                                              );
                                            },
                                            widget: CachedNetworkImage(
                                              width: 90,
                                              height: 90,
                                              imageUrl:
                                                  "${AppLink.reviewImage}${controller.reviewImageUrl[index]}",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.black26,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  color: Colors.black26,
                                                ),
                                              ),
                                            ));
                                  },
                                ),
                                if (controller.reviewImageUrl.isNotEmpty)
                                  ...List.generate(
                                      controller.selectedImages.length,
                                      (index) => CustomPickedImage(
                                          function: () {
                                            customModalBottomSheet(
                                              context,
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomPhotoListTile(
                                                      icon: FontAwesomeIcons
                                                          .trash,
                                                      function: () {
                                                        controller
                                                            .selectedImages
                                                            .removeAt(index);
                                                        controller.update();
                                                        Navigator.pop(context);
                                                      },
                                                      text: "Remove")
                                                ],
                                              ),
                                            );
                                          },
                                          widget: Image.file(
                                            controller.selectedImages[index]!,
                                          )))
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child: SizedBox(
                                  height: 90,
                                  width: controller.selectedImages.isNotEmpty ||
                                          controller.reviewImageUrl.isNotEmpty
                                      ? 90
                                      : controller.size.value.width * .92,
                                  child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      color: Colors.teal,
                                      strokeWidth: 1,
                                      child: Center(
                                        child: SizedBox(
                                          height: 90,
                                          width: 90,
                                          child: Center(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 28,
                                                    color: Colors.teal,
                                                  ),
                                                  SizedBox(
                                                    height: 1,
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
                                          ),
                                        ),
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: controller.feedbackController,
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: null,
                        maxLines: 12,
                        decoration: InputDecoration(
                          hintText: "Share your thoughts and feedback...",
                          focusedErrorBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1)),
                          errorMaxLines: 2,
                          errorStyle: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(fontSize: 13, color: Colors.red),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.black45),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: .5,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SpacerWidget(),
                    ]),
              );
            }),
          ),
          bottomNavigationBar:
              GetBuilder<UpdateReviewController>(builder: (controller) {
            return Container(
              padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(1, 0),
                    blurRadius: 5,
                    spreadRadius: 1.2,
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    return CustomButtonOrder(
                      color: controller.rate.value == 0
                          ? Colors.black26
                          : Colors.teal,
                      function: controller.statusRequest ==
                                  StatusRequest.loading ||
                              controller.statusRequest == StatusRequest.success
                          ? () {}
                          : () {
                              controller.updateFeedback();
                            },
                      text: controller.statusRequest == StatusRequest.loading
                          ? "PROCESSING"
                          : "SUBMIT",
                      colorText: Colors.white,
                      colorBorder: Colors.transparent,
                    );
                  }),
                ],
              ),
            );
          })),
    );
  }
}
