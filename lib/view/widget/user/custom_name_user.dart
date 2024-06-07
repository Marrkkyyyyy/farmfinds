import 'package:flutter/material.dart';

class CustomName extends StatelessWidget {
  const CustomName(
      {super.key,
      required this.name,
      required this.size,
      required this.textColor});
  final String name;
  final Size size;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        child: Text(
          name,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}
