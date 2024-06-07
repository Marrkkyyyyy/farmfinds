import 'package:flutter/material.dart';

class CustomHomeShopName extends StatelessWidget {

  final String text;
  const CustomHomeShopName(
      {super.key,  required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style:
          Theme.of(context).textTheme.headline1!.copyWith(color: Colors.teal),
    );
  }
}
