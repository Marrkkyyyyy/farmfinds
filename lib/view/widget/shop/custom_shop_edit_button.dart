import 'package:flutter/material.dart';

class CustomShopEditButton extends StatelessWidget {
  const CustomShopEditButton(
      {super.key, required this.function, required this.text});
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 3),
        decoration: BoxDecoration(
            color: Colors.white, border: Border.all(color: Colors.teal)),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.teal),
        ),
      ),
    );
  }
}
