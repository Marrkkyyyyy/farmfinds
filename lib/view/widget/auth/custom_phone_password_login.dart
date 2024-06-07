import 'package:flutter/material.dart';

class CustomPhonePasswordLogin extends StatelessWidget {
  const CustomPhonePasswordLogin(
      {super.key, required this.text, required this.function});
  final Function function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.teal),
        ),
      ),
    );
  }
}
