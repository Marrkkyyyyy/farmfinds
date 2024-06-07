import 'package:flutter/material.dart';

class CustomVariationTitle extends StatelessWidget {
  const CustomVariationTitle({super.key, required this.text,required this.textStyle});
  final String text;
  final TextStyle textStyle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
