import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  const CustomProfile(
      {super.key,
      required this.size,
      required this.widget,
      required this.backgroundColor});
  final Size size;
  final Widget widget;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * .07,
      width: size.width * .15,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: backgroundColor,
            child: widget,
          ),
        ],
      ),
    );
  }
}
