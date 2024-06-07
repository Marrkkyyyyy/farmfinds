import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/product_review_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_review_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CustomProductPreview extends StatelessWidget {
  CustomProductPreview({super.key});
  final controller = Get.find<ProductProfileController>();
  @override
  Widget build(BuildContext context) {
    return controller.statusRequest == StatusRequest.success
        ? Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: GoogleFonts.manrope(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                              text: '',
                              children: [
                            TextSpan(
                                text: "Review",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                )),
                            TextSpan(text: " "),
                            TextSpan(
                                text: "(${controller.productReviews.length})",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 16)),
                          ])),
                      controller.productReviews.length <= 5
                          ? SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.viewAllProductRating);
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "View All",
                                    style: GoogleFonts.manrope(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const FaIcon(
                                    FontAwesomeIcons.angleRight,
                                    size: 16,
                                    color: Colors.black54,
                                  )
                                ],
                              ),
                            ),
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: .7),
                            text: '',
                            children: [
                          TextSpan(
                              text: "${controller.totalRate.value}",
                              style: GoogleFonts.manrope(
                                color: Colors.black,
                                fontSize: 16,
                              )),
                          TextSpan(
                              text: "/",
                              style: GoogleFonts.manrope(
                                  color: Colors.black54, fontSize: 14)),
                        ])),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("5",
                            style: GoogleFonts.manrope(
                                color: Colors.black54, fontSize: 12)),
                        RatingBarIndicator(
                          rating: controller.totalRate.value,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Column(
                  children: List.generate(
                    controller.productReviews.length <= 5
                        ? controller.productReviews.length
                        : 5,
                    (index) {
                      ProductReviewModel review =
                          controller.productReviews[index];
                      DateTime reviewDate = DateTime.parse(review.reviewDate!);
                      String formattedReviewDate =
                          DateFormat('MM-dd-yyyy HH:mm').format(reviewDate);
                      List<String> reviewImageUrl = [];
                      if (review.reviewImageUrl != "null") {
                        reviewImageUrl = review.reviewImageUrl!.split(",");
                      }
                      return Container(
                        width: controller.size.value.width,
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(115, 235, 235, 235),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                review.fullName!,
                                style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RatingBarIndicator(
                                rating: double.parse(review.rating!),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 16.0,
                                direction: Axis.horizontal,
                              ),
                              review.review[0].variationName! == "null"
                                  ? SizedBox(
                                      height: 12,
                                    )
                                  : Container(
                                      padding:
                                          EdgeInsets.only(bottom: 8, top: 8),
                                      child: Text(
                                        "Variation: ${review.review.where((e) => e.variationName != "null").map((e) => e.variationName).join(", ")}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: Colors.black45,
                                            ),
                                      ),
                                    ),
                              review.comment! == "null"
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.only(
                                          bottom:
                                              review.reviewImageUrl! == "null"
                                                  ? 8
                                                  : 0),
                                      child: Text(
                                        review.comment!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                              color: Colors.black87,
                                            ),
                                      ),
                                    ),
                              reviewImageUrl.isEmpty
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.only(
                                          bottom: 12,
                                          top: review.comment! == "null"
                                              ? 0
                                              : 4),
                                      child: Row(
                                        children: List.generate(
                                          reviewImageUrl.length < 2
                                              ? reviewImageUrl.length
                                              : 2,
                                          (indexReview) => GestureDetector(
                                            onTap: () {
                                              Get.to(() => CustomReviewImages(
                                                  image:
                                                      "${AppLink.reviewImage}${reviewImageUrl[indexReview]}",
                                                  currentIndex: indexReview,
                                                  totalImages:
                                                      reviewImageUrl.length,
                                                  imageUrl: reviewImageUrl));
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(right: 12),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(14)),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${AppLink.reviewImage}${reviewImageUrl[indexReview]}",
                                                  fit: BoxFit.cover,
                                                  width: 75,
                                                  height: 75,
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor: Colors.black26,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  14)),
                                                      child: Container(
                                                        color: Colors.black26,
                                                        width: 75,
                                                        height: 75,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )..add(
                                            reviewImageUrl.length == 3
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          CustomReviewImages(
                                                            image:
                                                                "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                            currentIndex: 2,
                                                            totalImages:
                                                                reviewImageUrl
                                                                    .length,
                                                            imageUrl:
                                                                reviewImageUrl,
                                                          ));
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 12),
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            14)),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                              fit: BoxFit.cover,
                                                              width: 75,
                                                              height: 75,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Shimmer
                                                                      .fromColors(
                                                                baseColor: Colors
                                                                    .black26,
                                                                highlightColor:
                                                                    Colors
                                                                        .white,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              14)),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                        .black26,
                                                                    width: 75,
                                                                    height: 75,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : reviewImageUrl.length > 2
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              CustomReviewImages(
                                                                image:
                                                                    "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                currentIndex: 2,
                                                                totalImages:
                                                                    reviewImageUrl
                                                                        .length,
                                                                imageUrl:
                                                                    reviewImageUrl,
                                                              ));
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 12),
                                                          child: Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            14)),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl:
                                                                      "${AppLink.reviewImage}${reviewImageUrl[2]}",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 75,
                                                                  height: 75,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Shimmer
                                                                          .fromColors(
                                                                    baseColor:
                                                                        Colors
                                                                            .black26,
                                                                    highlightColor:
                                                                        Colors
                                                                            .white,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(14)),
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .black26,
                                                                        width:
                                                                            75,
                                                                        height:
                                                                            75,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned.fill(
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(14)),
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                    ),
                                                                    width: 75,
                                                                    height: 75,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "+${reviewImageUrl.length - 3}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                          ),
                                      ),
                                    ),
                              Text(
                                formattedReviewDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.black45),
                              )
                            ]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                controller.productReviews.length <= 5
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.viewAllProductRating);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(width: .05),
                                  bottom: BorderSide(width: .05))),
                          width: controller.size.value.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "View More",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Colors.black54, fontSize: 14),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 14,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                      )
              ],
            ),
          )
        : controller.statusRequest == StatusRequest.offlinefailure ||
                controller.statusRequest == StatusRequest.serverfailure ||
                controller.statusRequest == StatusRequest.failure ||
                controller.statusRequest == StatusRequest.loading
            ? SizedBox()
            : controller.productReviews.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 8, top: 6, bottom: 6),
                        child: Text(
                          "No ratings yet",
                          style: Theme.of(context).textTheme.headline5!,
                        ),
                      ),
                    ],
                  )
                : SizedBox();
  }
}
