import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/reviews/to_review_controller.dart';
import 'package:ecommerce/core/class/handling_data_request.dart';
import 'package:ecommerce/core/constant/image_asset.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/review_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/rating/custom_my_review_images.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class MyReviews extends StatelessWidget {
  MyReviews({super.key});
  final controller = Get.put(ToReviewController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.initData(),
      child: GetBuilder<ToReviewController>(builder: (controller) {
        return HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: controller.myReviews.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: controller.size.value.height * .15,
                      ),
                      Lottie.asset(AppImageASset.noProduct,
                          width: 200, height: 200),
                      Text(
                        "No product reviews",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.black87),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 15),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                        children:
                            List.generate(controller.myReviews.length, (index) {
                      ReviewModel reviews = controller.myReviews[index];
                      DateTime reviewDate = DateTime.parse(reviews.reviewDate!);
                      String formattedReviewDate =
                          DateFormat('MM-dd-yyyy HH:mm').format(reviewDate);
                      List<String> reviewImageUrl =
                          reviews.reviewImageUrl!.split(",");

                      return Column(
                        children: [
                          SpacerWidget(),
                          Container(
                            width: controller.size.value.width,
                            padding: const EdgeInsets.only(
                                top: 12, left: 12, bottom: 8),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: controller.size.value.height * 0.03,
                                  width: controller.size.value.height * 0.03,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(12, 0, 0, 0),
                                        child: controller.userProfile == "" ||
                                                controller.userProfile == "null"
                                            ? Icon(
                                                Icons.person,
                                                size: 20,
                                                color: Colors.teal,
                                              )
                                            : ClipOval(
                                                child: CachedNetworkImage(
                                                  width: 35,
                                                  height: 35,
                                                  imageUrl:
                                                      "${AppLink.userProfile}${controller.userProfile}",
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: Colors.black26,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      color: Colors.black26,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.black87,
                                              width: .3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.fullName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      RatingBarIndicator(
                                        rating: double.parse(reviews.rating!),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 16.0,
                                        direction: Axis.horizontal,
                                      ),
                                      Container(
                                        width:
                                            controller.size.value.width * .85,
                                        padding:
                                            EdgeInsets.only(bottom: 8, top: 8),
                                        child: Text(
                                          "$formattedReviewDate ${reviews.order.where((e) => e.variationName != "null").map((e) => e.variationName).join(", ")}",
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black45,
                                                  fontSize: 14),
                                        ),
                                      ),
                                      reviews.comment == "null" ||
                                              reviews.comment == ""
                                          ? SizedBox()
                                          : Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              width:
                                                  controller.size.value.width *
                                                      .85,
                                              child: Text(
                                                reviews.comment!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: Colors.black87,
                                                    ),
                                              ),
                                            ),
                                      reviews.reviewImageUrl! == "null" ||
                                              reviews.reviewImageUrl!.isEmpty
                                          ? SizedBox()
                                          : Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                  children:
                                                      List.generate(
                                                          reviewImageUrl
                                                                      .length <
                                                                  2
                                                              ? reviewImageUrl
                                                                  .length
                                                              : 2,
                                                          (indexReview) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.to(() =>
                                                        CustomMyReviewImages(
                                                          image:
                                                              "${AppLink.reviewImage}${reviewImageUrl[indexReview]}",
                                                          currentIndex:
                                                              indexReview,
                                                          totalImages:
                                                              reviewImageUrl
                                                                  .length,
                                                          imageUrl:
                                                              reviewImageUrl,
                                                        ));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          "${AppLink.reviewImage}${reviewImageUrl[indexReview]}",
                                                      fit: BoxFit.cover,
                                                      width: 90,
                                                      height: 90,
                                                      placeholder: (context,
                                                              url) =>
                                                          Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.black26,
                                                        highlightColor:
                                                            Colors.white,
                                                        child: Container(
                                                          color: Colors.black26,
                                                          width: 90,
                                                          height: 90,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                                        ..add(
                                                          reviewImageUrl
                                                                      .length ==
                                                                  3
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(() =>
                                                                        CustomMyReviewImages(
                                                                          image:
                                                                              "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                          currentIndex:
                                                                              2,
                                                                          totalImages:
                                                                              reviewImageUrl.length,
                                                                          imageUrl:
                                                                              reviewImageUrl,
                                                                        ));
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                8),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        CachedNetworkImage(
                                                                          imageUrl:
                                                                              "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              90,
                                                                          placeholder: (context, url) =>
                                                                              Shimmer.fromColors(
                                                                            baseColor:
                                                                                Colors.black26,
                                                                            highlightColor:
                                                                                Colors.white,
                                                                            child:
                                                                                Container(
                                                                              color: Colors.black26,
                                                                              width: 90,
                                                                              height: 90,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : reviewImageUrl
                                                                          .length >
                                                                      2
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.to(() =>
                                                                            CustomMyReviewImages(
                                                                              image: "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                              currentIndex: 2,
                                                                              totalImages: reviewImageUrl.length,
                                                                              imageUrl: reviewImageUrl,
                                                                            ));
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.only(right: 8),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            CachedNetworkImage(
                                                                              imageUrl: "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                              fit: BoxFit.cover,
                                                                              width: 90,
                                                                              height: 90,
                                                                              placeholder: (context, url) => Shimmer.fromColors(
                                                                                baseColor: Colors.black26,
                                                                                highlightColor: Colors.white,
                                                                                child: Container(
                                                                                  color: Colors.black26,
                                                                                  width: 90,
                                                                                  height: 90,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Positioned.fill(
                                                                              child: Align(
                                                                                alignment: Alignment.center,
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.black.withOpacity(0.5),
                                                                                  ),
                                                                                  width: 90,
                                                                                  height: 90,
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      "+${reviewImageUrl.length - 3}",
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : SizedBox(),
                                                        )),
                                            ),
                                      Column(
                                          children: List.generate(
                                              reviews.order.length,
                                              (reviewIndex) {
                                        ReviewItem reviewItem =
                                            reviews.order[reviewIndex];
                                        return GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoute.productProfile,
                                                arguments:
                                                    reviewItem.productID);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                              bottom: reviewIndex ==
                                                      reviews.order.last
                                                  ? 0
                                                  : 12,
                                            ),
                                            child: Row(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl:
                                                      "${AppLink.productImage}${reviewItem.productImageUrl}",
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: Colors.black26,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      color: Colors.black26,
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 50,
                                                  color: Color.fromARGB(
                                                      17, 0, 0, 0),
                                                  width: controller
                                                          .size.value.width *
                                                      0.74,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8),
                                                        child: Text(
                                                          reviewItem
                                                              .productName!,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      })),
                                    ]),
                              ],
                            ),
                          ),
                          int.parse(reviews.dateDiff!) >= 2
                              ? SizedBox()
                              : GestureDetector(
                                  onTap: () async {
                                    final result = await Get.toNamed(
                                        AppRoute.updateReview,
                                        arguments: {"reviews": reviews});

                                    if (result == true) {
                                      await controller.initData();
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.penToSquare,
                                        size: 16,
                                        color: Colors.teal,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "Edit",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.teal,
                                                fontSize: 14),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      );
                    }).reversed.toList()),
                  ),
                ),
        );
      }),
    );
  }
}
