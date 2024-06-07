import 'package:flutter/material.dart';

class CustomAuthNavigator extends StatelessWidget {
  const CustomAuthNavigator(
      {super.key, required this.text, required this.function});
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1!.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Colors.teal,
              decorationThickness: 1.0,
              color: Colors.teal,
            ),
      ),
    );
  }
}
