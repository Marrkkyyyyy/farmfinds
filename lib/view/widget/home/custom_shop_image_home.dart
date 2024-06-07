import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShopImageHome extends StatelessWidget {
  final String image;
  final String heroTag;
  const CustomShopImageHome({super.key, required this.image,required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return Hero(tag:heroTag,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Color.fromARGB(45, 0, 0, 0),
          highlightColor: Colors.white,
          child: Container(
            color: Color.fromARGB(45, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}
