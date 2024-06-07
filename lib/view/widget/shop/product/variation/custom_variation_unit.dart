import 'package:flutter/material.dart';

class CustomVariationUnit extends StatelessWidget {
  const CustomVariationUnit({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontWeight: FontWeight.w600, color: Colors.black),
    );
  }
}
