import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomPickedImage extends StatelessWidget {
  const CustomPickedImage(
      {super.key, required this.function, required this.widget});
  final Function function;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: SizedBox(
          height: 90,
          width: 90,
          child: DottedBorder(
              borderType: BorderType.RRect,
              color: Colors.teal,
              strokeWidth: 1,
              child: SizedBox(
                height: 90,
                width: 90,
                child: widget,
              )),
        ),
      ),
    );
  }
}
