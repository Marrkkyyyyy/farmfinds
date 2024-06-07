import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/link_api.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomImageDisplay extends StatelessWidget {
  const CustomImageDisplay(
      {super.key,
      required this.size,
      required this.onPageChaged,
      required this.imageURLs});
  final Size size;
  final Function(int, CarouselPageChangedReason) onPageChaged;
  final List<String> imageURLs;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        height: size.height * 0.4,
        onPageChanged: onPageChaged,
      ),
      items: imageURLs.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Center(
              child: CachedNetworkImage(
                imageUrl: "${AppLink.vegetableImage}$imageUrl",
                fit: BoxFit.cover,
                width: double.infinity,
                height: size.height * 0.4,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.black26,
                  highlightColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: size.height * 0.4,
                    color: Colors.black26,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
