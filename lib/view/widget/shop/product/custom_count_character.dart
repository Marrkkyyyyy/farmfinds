import 'package:flutter/material.dart';

class CustomCountCharacter extends StatelessWidget {
  const CustomCountCharacter({super.key, required this.count,required this.maxLength});
  final String count;
  final String maxLength;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$count / $maxLength",
      style: Theme.of(context)
          .textTheme
          .headline5!
          .copyWith(color: Colors.black54, fontWeight: FontWeight.w600),
    );
  }
}
