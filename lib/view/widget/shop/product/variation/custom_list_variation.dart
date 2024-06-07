import 'package:flutter/material.dart';

class CustomListVariation extends StatelessWidget {
  const CustomListVariation({super.key,required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.black54),
    );
  }
}
