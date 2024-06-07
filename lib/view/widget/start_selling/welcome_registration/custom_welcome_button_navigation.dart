import 'package:flutter/material.dart';

class CustomWelcomeButtonNavigationBar extends StatelessWidget {
  const CustomWelcomeButtonNavigationBar(
      {super.key,
      required this.size,
      required this.text,
      required this.function});
  final Size size;
  final String text;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Colors.white,
      child: TextButton(
        style: TextButton.styleFrom(
            fixedSize: Size(size.width * .8, 47),
            backgroundColor: const Color.fromARGB(255, 31, 129, 121),
            shape: const RoundedRectangleBorder()),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
        onPressed: () {
          function();
        },
      ),
    );
  }
}
