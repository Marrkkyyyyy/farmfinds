import 'package:flutter/material.dart';

class CustomAuthButtonUser extends StatelessWidget {
  const CustomAuthButtonUser({super.key, required this.function,required this.text});
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.black54),
        ),
      ),
    );
  }
}
