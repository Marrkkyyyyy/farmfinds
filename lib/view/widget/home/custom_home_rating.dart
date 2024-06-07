import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomHomeRating extends StatelessWidget {
  final double rate;
  final Widget rateText;
  const CustomHomeRating({super.key, required this.rate, required this.rateText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: rate,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
        ),
        Container(
          width: 1,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          color: Colors.black26,
        ),
        rateText
      ],
    );
  }
}
