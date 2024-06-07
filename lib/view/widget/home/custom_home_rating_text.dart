import 'package:flutter/material.dart';

class CustomHomeRatingText extends StatelessWidget {
  final String rateText;
  const CustomHomeRatingText({super.key, required this.rateText});

  @override
  Widget build(BuildContext context) {
    return Text(
        "${rateText == "0.0" ? "No ratings yet" : rateText + " Ratings"} ",
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.black54, fontWeight: FontWeight.w600));
  }
}
