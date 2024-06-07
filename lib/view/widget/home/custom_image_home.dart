import 'package:flutter/material.dart';

class CustomImageHome extends StatelessWidget {
  final Size size;
  final Widget image;
  const CustomImageHome({super.key, required this.size, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .15,
      width: size.width * .3,
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: image),
    );
  }
}
