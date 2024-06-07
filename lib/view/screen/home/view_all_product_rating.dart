import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/home/product_profile_controller.dart';
import 'package:ecommerce/core/constant/routes.dart';
import 'package:ecommerce/data/model/new/product_review_model.dart';
import 'package:ecommerce/link_api.dart';
import 'package:ecommerce/view/widget/home/custom_product_add_to_cart.dart';
import 'package:ecommerce/view/widget/home/custom_review_images.dart';
import 'package:ecommerce/view/widget/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ViewAllProductRating extends StatelessWidget {
  ViewAllProductRating({super.key});
  final controller = Get.find<ProductProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        elevation: 2,
        leadingWidth: 34,
        title: const Text(
          "Ratings",
        ),
        actions: [
          GestureDetector(
            onTap: () {
              if (controller.userID == null) {
                Get.toNamed(AppRoute.login);
              } else {
                Get.toNamed(AppRoute.cartPage);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: Colors.teal,
                    size: 19,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SpacerWidget(),
            Column(
              children: List.generate(
                controller.productReviews.length,
                (index) {
                  ProductReviewModel review = controller.productReviews[index];
                  DateTime reviewDate = DateTime.parse(
                      controller.productReviews[index].reviewDate!);
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
                        borderRadius: BorderRadius.all(Radius.circular(12))),
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
                            height: 6,
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
                                  padding: EdgeInsets.only(bottom: 8, top: 8),
                                  child: Text(
                                    "Variation:  ${review.review.where((e) => e.variationName != "null").map((e) => e.variationName).join(", ")}",
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
                                      bottom: review.reviewImageUrl! == "null"
                                          ? 8
                                          : 0),
                                  child: Text(
                                    controller.productReviews[index].comment!,
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
                                      top: review.comment! == "null" ? 0 : 8),
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
                                          padding: EdgeInsets.only(right: 12),
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
                                                highlightColor: Colors.white,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(14)),
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
                                        reviewImageUrl.length > 3
                                            ? GestureDetector(
                                                onTap: () {
                                                  Get.to(
                                                      () => CustomReviewImages(
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
                                                            BorderRadius.all(
                                                                Radius.circular(
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
                                                            baseColor:
                                                                Colors.black26,
                                                            highlightColor:
                                                                Colors.white,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          14)),
                                                              child: Container(
                                                                color: Colors
                                                                    .black26,
                                                                width: 75,
                                                                height: 75,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          14)),
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                            ),
                                                            width: 75,
                                                            height: 75,
                                                            child: Center(
                                                              child: Text(
                                                                "+${reviewImageUrl.length - 3}",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
              height: 5,
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomProductAddToCart(),
    );
  }
}
