import 'package:ecommerce/controller/reviews/to_review_controller.dart';
import 'package:ecommerce/core/class/status_request.dart';
import 'package:ecommerce/view/screen/rating/to_review.dart';
import 'package:ecommerce/view/screen/rating/my_reviews.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyRating extends StatelessWidget {
  MyRating({super.key});
  final controller = Get.put(ToReviewController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          title: Text("My Rating"),
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
            indicatorWeight: 1,
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.normal),
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            labelStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w600),
            tabs: [
              GetBuilder<ToReviewController>(builder: (controller) {
                return Tab(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text("To Review"),
                      ),
                      controller.statusRequest != StatusRequest.success
                          ? SizedBox()
                          : controller.toRateOrders.length.toString() ==
                                  "0"
                              ? SizedBox()
                              : Positioned(
                                  bottom: 19,
                                  right: 22,
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.teal,
                                    ),
                                    child: Text(
                                      controller.toRateOrders.length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 13),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                );
              }),
              Tab(
                child: Text("My Reviews"),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => controller.initData(),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ToReview(),
                      MyReviews(),
                    ]),
              )

              // Add other SliverToBoxAdapter or Sliver widgets for other sections
            ],
          ),
        ),
      ),
    );
  }
}
