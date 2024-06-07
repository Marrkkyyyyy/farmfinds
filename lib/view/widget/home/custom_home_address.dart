import 'package:flutter/material.dart';

class CustomHomeAddress extends StatelessWidget {
  final String address;
  final int maxLines;
  const CustomHomeAddress({super.key, required this.address, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      address,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.black54, fontWeight: FontWeight.w300),
    );
  }
}
