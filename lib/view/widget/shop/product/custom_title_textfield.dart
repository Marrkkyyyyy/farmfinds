import 'package:flutter/material.dart';

class CustomTitleTextfield extends StatelessWidget {
  const CustomTitleTextfield(
      {super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.black),
        );
  }
}
