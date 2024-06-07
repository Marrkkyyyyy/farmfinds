import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/controller/reviews/to_review_controller.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomMyReviewImages extends StatelessWidget {
  const CustomMyReviewImages({
    Key? key,
    required this.image,
    required this.currentIndex,
    required this.totalImages,
    required this.imageUrl,
  }) : super(key: key);

  final String image;
  final int currentIndex;
  final int totalImages;
  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ToReviewController>();
    controller.currentPage.value = currentIndex;

    return GetBuilder<ToReviewController>(builder: (controller) {
      return SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              itemCount: totalImages,
              controller: PageController(initialPage: currentIndex),
              onPageChanged: (int index) {
                controller.currentPage.value = index;
              },
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.black,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: totalImages == 1
                          ? "$image"
                          : "${AppLink.reviewImage}${imageUrl[index]}",
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Color.fromARGB(45, 0, 0, 0),
                        highlightColor: Colors.white,
                        child: Container(
                          color: Color.fromARGB(45, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Obx(() {
                    return Text(
                      '${controller.currentPage.value + 1}/$totalImages',
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
