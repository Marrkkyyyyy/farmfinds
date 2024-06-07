import 'package:flutter/material.dart';

class CustomTipsTitle extends StatelessWidget {
  const CustomTipsTitle({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1!.copyWith(
            color: Colors.black87,
          ),
    );
  }
}
