import 'package:flutter/material.dart';

class CustomButtonOrder extends StatelessWidget {
  const CustomButtonOrder(
      {super.key,
      required this.function,
      required this.text,
      this.color = Colors.transparent,
      this.colorBorder = Colors.black54, required this.colorText });
  final Function function;
  final String text;
  final Color color;
  final Color colorBorder;
  final Color colorText;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 1, 40),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colorBorder, width: .7),
        ),
        backgroundColor: color,
      ),
      onPressed: () {
        function();
      },
      child: Text(text,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: colorText)),
    );
  }
}
