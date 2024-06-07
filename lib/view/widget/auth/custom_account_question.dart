import 'package:flutter/material.dart';

class CustomAccountQuestion extends StatelessWidget {
  const CustomAccountQuestion({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
    );
  }
}
