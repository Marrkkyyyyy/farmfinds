import 'package:flutter/material.dart';

class CustomBackgroundShopRegistration extends StatelessWidget {
  const CustomBackgroundShopRegistration(
      {super.key, required this.size, required this.widget});
  final Size size;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.35,
      width: size.width * 1,
      child: widget,
    );
  }
}
